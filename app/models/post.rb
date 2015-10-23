class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:finders]

  validates :title, :author, presence: true
  validates :subs, length: { minimum: 1 }


  has_many :comments
  has_many :votes, as: :votable

  has_many(
    :post_subs
  )

  has_many(
    :subs,
    through: :post_subs
  )

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  def comments_by_parent_id
    # comments.inject(Hash.new { [] }) { |acc, c| acc[c.parent_comment_id] + [c] }
    result = Hash.new { [] }

    comments.each { |comment| result[comment.parent_comment_id] += [comment] }

    result
  end

  def count_votes(type)
    bool = (type == :upvote ? true : false)
    votes.where(upvote: bool).length
  end

  def score
    count_votes(:upvote) - count_votes(:downvote)
  end
end
