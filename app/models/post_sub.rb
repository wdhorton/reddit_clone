class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true
  validates_uniqueness_of :sub, scope: :post

  belongs_to :sub
  belongs_to :post
end
