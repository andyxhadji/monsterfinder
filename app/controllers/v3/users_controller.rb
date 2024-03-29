class V3::UsersController < V3::BaseController

  skip_before_filter :verify_authenticity_token

  def show
    user = User.where(uuid: params[:id]).first
    spots = user.monsters.order("total_vote_count desc")
    render json: ProfileBuilder.new(user, spots).render.to_json
  end

  def vote
    # needs uuid to make sure hasnt already voted
    u = User.where(uuid: params[:uuid]).first
    m = Monster.find(params[:monster_id])
    a = Activity.where(
      user: u,
      monster: m,
      activity_type: [1, 2]
    ).first
    if a.nil?
      Activity.create(
        user: u,
        monster: m,
        activity_type: which_vote
      )
    end

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def update_channel_id
    u = User.where(uuid: params[:uuid]).first
    u.channel_id = params[:channel_id]
    u.save
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def remove_notifications
    Activity.where(user: User.where(uuid: params[:uuid]).first).notifications.destroy_all
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def replace_notification
    remove = Monster::MONSTERS.index(params[:remove])
    add = Monster::MONSTERS.index(params[:add])
    if remove
      a = Activity.where(
        user: User.where(uuid: params[:uuid]).first,
        activity_type: 3,
        monster_number: remove
      )
      a.destroy_all
    end
    if add
      a = Activity.new
      a.activity_type = "notify"
      a.user = User.where(uuid: params[:uuid]).first
      a.monster_number = add
      a.save
    end

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def which_vote
    params[:vote] == 'up' ? 'upvote' : 'downvote'
  end

  def create
    User.create(user_params)
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private

  def user_params
    params.require(:user).permit(:name, :uuid)
  end

end
