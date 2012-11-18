require "validators/email_validator"

class Participant < ActiveRecord::Base
  belongs_to :draw,  :dependent => :destroy
  has_one :pick, foreign_key: :picker_id

  validates :name, :presence => true, uniqueness: {scope: :draw_id}
  validates :email, :presence => true, :email => true, uniqueness: {scope: :draw_id}
  validates :draw_id, :presence => true

  def email_pick
    ParticipantMailer.pick_email(pick.id).deliver
  end
end
