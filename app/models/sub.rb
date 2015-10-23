class Sub < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:finders]

  validates :title, :moderator, presence: true

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id
  )

  has_many :post_subs

  has_many(
    :posts,
    through: :post_subs
  )

end
