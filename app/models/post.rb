# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Post < ActiveRecord::Base

  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id', :include => [ :profile ]
  belongs_to :user

  validates :body, presence: true, :length => { maximum: 6000 }
  validates :author, :user, presence: true

  acts_as_api
  api_accessible :angular do |t|
    t.add :id
    t.add :body
    t.add :created_at
    t.add :author, :template => :angular
    t.add :deleted_at
    t.add :user_id
  end

  acts_as_paranoid
end
