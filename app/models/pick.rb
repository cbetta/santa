class Pick < ActiveRecord::Base
  
  belongs_to :draw
  belongs_to :picker, :class_name => "Participant"
  belongs_to :picked, :class_name => "Participant"
  
  validates :picker_id, :uniqueness => {scope: :draw_id }
  validates :picked_id, :uniqueness => {scope: :draw_id }
  
  before_create :generate_hash
  
  def to_param
    "#{hash}"
  end
  
private

  def generate_hash
    self.hash = ActiveSupport::SecureRandom.hex(16)
  end

end
