class Draw < ActiveRecord::Base
  attr_accessible :title, :message
  
  validates :title, :presence => true, :length => {minimum: 5, maximum: 255}
  validates :message, :presence => true, :length => {minimum: 10, maximum: 2000}
  
  has_many :participants
  has_many :picks
  
  belongs_to :user

private


  
end
