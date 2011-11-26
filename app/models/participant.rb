require "validators/email_validator"

class Participant < ActiveRecord::Base
  belongs_to :draw,  :dependent => :destroy
  has_one :pick, foreign_key: :picker_id
  has_one :pickee, :through => :pick, foreign_key: :pickee_id
  
  validates :name, :presence => true, uniqueness: {scope: :draw_id}
  validates :email, :presence => true, :email => true, uniqueness: {scope: :draw_id}
  validates :draw_id, :presence => true
end
