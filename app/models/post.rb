# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :subs, :author_id, presence: true

  belongs_to :sub
  belongs_to :author, class_name: 'User'
  has_many :postings, class_name: 'PostSub', dependent: :destroy
  has_many :subs, through: :postings, source: :sub
  has_many :comments, foreign_key: :post_id
end
