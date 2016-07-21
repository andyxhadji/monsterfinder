include ActionView::Helpers::DateHelper
class MonsterBuilder
  attr_accessor :monsters

  def initialize(monsters)
    self.monsters = monsters
  end

  def render
    monsters.map do |monster|
      {
        id: monster.id,
        name: monster.name,
        lat: monster.lat,
        lng: monster.lng,
        created_at: monster.created_at,
        number: monster.number,
        spotterName: monster.activities.spot.first&.user&.name || "",
        upVotes: monster.upvote_count,
        downVotes: monster.downvote_count,
        totalVotes: monster.total_vote_count
      }
    end
  end
end
