class Draw < ActiveRecord::Base
  attr_accessible :title, :message, :previous_draw_id

  validates :title, :presence => true, :length => {minimum: 5, maximum: 255}
  validates :message, :presence => true, :length => {minimum: 10, maximum: 2000}

  has_many :participants
  has_many :picks, :dependent => :delete_all

  belongs_to :user
  belongs_to :previous_draw, class_name: "Draw"

  after_create :import_previous_participants

  ### undos a draw ###
  def undo
    self.picks.delete_all
    self.drawn = false
    self.drawn_on = nil
    save
  end

  ### Makes a draw by matching participants ###
  def make
    unless drawn
      #start with 2 list of IDs
      pickers = participants.map(&:id)
      pickees = participants.map(&:id)
      selections = Hash.new

      #go onto the last 2
      while pickers.count > 2
        #get a random picker
  			picker = pickers.shuffle!.pop
  			#limit the list of potential pickees
        allowed_pickees = Array.new(pickees)
        allowed_pickees.delete(picker)
        allowed_pickees.delete(previous_pick_for(picker).picked_id) if previous_draw
        #get a random pickee
        pickee = allowed_pickees.shuffle!.pop
        #store the match
  			selections[picker] = pickee
  			#delete the pickee from the allowed list
  			pickees.delete(pickee)
      end

      # the last 2 might only have 1 way they fit
      pickers.reverse! if pickers[0] == pickees[0] || pickers[1] == pickees[1]
      selections[pickers[0]] = pickees[0]
      selections[pickers[1]] = pickees[1]

      #store the picks
      selections.each do |picker, pickee|
        Pick.create!(:picker_id => picker, :picked_id => pickee, draw_id: id)
      end

      self.drawn = true
      self.drawn_on = Time.now
      save
    end
  end

  def previous_pick_for(picker)
    previous_draw.picks.joins(:picker).where("participants.email = ?", Participant.find(picker).email).first
  end

  ### Tests the making process ###
  def test
    10000.times do |i|
      puts "try #{i}"
      picks = make
      puts picks.inspect
      picks.each do |picker, pickee|
        raise "Invalid found" if picker == pickee
      end
    end
  end

  ### emails all participants a link to their draw
  def email_participants
    self.participants.each(&:email_pick)
  end

  def import_previous_participants
    participants = previous_draw.participants.map do |participant|
      new_participant = participant.dup
      new_participant.draw = self
      new_participant.save!
      new_participant
    end
  end
end
