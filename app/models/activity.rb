class Activity < ActiveRecord::Base
  after_save :update_counter_cache
  after_destroy :update_counter_cache
  
  belongs_to :monster
  belongs_to :user
  scope :spot, -> { where(activity_type: 0) }
  scope :upVotes, -> { where(activity_type: 1) }
  scope :downVotes, -> { where(activity_type: 2) }
  validates_inclusion_of :activity_type, :in => ["spot", "upvote", "downvote"], :allow_nil => false

  enum activity_type: {
    "spot" => 0,
    "upvote" => 1,
    "downvote" => 2
  }

  def update_counter_cache
    case activity_type
    when "upvote"
      monster.upvote_count = Activity.where(monster: monster).upVotes.count
      monster.save!
    when "downvote"
      monster.downvote_count = Activity.where(monster: monster).downVotes.count
      monster.save!
    end
  end


end
