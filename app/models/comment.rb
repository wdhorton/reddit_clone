class Comment < ActiveRecord::Base
  validates :content, :post, :author, presence: true

  belongs_to :post

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  has_many :votes, as: :votable

  has_many(
    :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )

  def count_votes(type)
    bool = (type == :upvote ? true : false)
    votes.where(upvote: bool).length
  end

  def score
    count_votes(:upvote) - count_votes(:downvote)
  end
end
