class V1::MonstersController < V1::BaseController




  DISTANCE = 2

  skip_before_filter :verify_authenticity_token

  def index
    #render json: Monster.where.not(lat: nil).order('created_at desc')
    #  .where(created_at: 3.hours.ago..Time.now).all.to_json
    #expires_in 5.minutes, :public => true
    m = []
    if coordinates_exist?
      m = Monster
          .with_associations
          .recent(params[:recent] == 'true')
          .highly_rated(params[:rated] == 'true')
          .limit(50)
    end
    render json: MonsterBuilder.new(m).render.as_json
  end

  def create
    # check if name is a real pokemon
    # this can be delayed job
    if params.key?(:uuid)
      m = Monster.create(monster_params)
      # if user changes name, this doesnt work
      u = User.first_or_create!(uuid: params[:uuid], name: params[:name])
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

  private

  def monster_params
    params.require(:monster).permit(:monster, :name, :lat, :lng)
  end
end
