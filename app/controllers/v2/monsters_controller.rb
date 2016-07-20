class V2::MonstersController < V2::BaseController




  DISTANCE = 10

  skip_before_filter :verify_authenticity_token

  def index
    #render json: Monster.where.not(lat: nil).order('created_at desc')
    #  .where(created_at: 3.hours.ago..Time.now).all.to_json
    #expires_in 5.minutes, :public => true
    if params[:uuid] && params[:uuid] != "B8F90E0C-DCEB-499D-8E16-17AFECD07937"
      m = []
      if coordinates_exist?
        m = Monster
            .near(coordinates, DISTANCE)
            .with_associations
            .highly_rated(params[:rated] == 'true')
            .all
        if params[:uuid]
          u = User.where(uuid: params[:uuid]).first
          if u
            u.lat = params[:lat]
            u.lng = params[:lng]
            u.save
          end
        end
      end
      return render json: MonsterBuilder.new(m).render.as_json
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def create
    # check if name is a real pokemon
    # this can be delayed job
    if params.key?(:uuid)
      m = Monster.create(monster_params)
      # if user changes name, this doesnt work
      u = User.where(uuid: params[:uuid]).last
      if u.nil?
        u = User.create(uuid: params[:uuid], name: params[:name])
      end
      Activity.create(user: u, monster: m, activity_type: "spot")
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def search
    monster = params[:monster].titleize
    if Monster::MONSTERS.include?(monster)
      m = if params[:recent] == 'true'
            Monster.recent.near(coordinates, DISTANCE).where(name: monster).all
          else
            Monster.near(coordinates, DISTANCE).where(name: monster).all
          end
      render json: MonsterBuilder.new(m).render.as_json
    else
      render json: []
    end
  end

  def coordinates
    [params[:lat], params[:lng]]
  end

  def coordinates_exist?
    params[:lat].to_f != 0.0 && params[:lng].to_f != 0.0
  end

  # delayed job
  def hide
    m = Monster.find(params[:monster_id])
    m.active = false
    m.save
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private

  def monster_params
    params.require(:monster).permit(:monster, :name, :lat, :lng)
  end
end
