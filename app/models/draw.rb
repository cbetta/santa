class Draw < ActiveRecord::Base
  attr_accessible :title, :message, :previous_draw_id

  validates :title, :presence => true, :length => {minimum: 5, maximum: 255}
  validates :message, :presence => true, :length => {minimum: 10, maximum: 2000}

  has_many :participants
  has_many :picks, :dependent => :delete_all

  belongs_to :user
  belongs_to :previous_draw, class_name: "Draw"

  after_create :import_previous_participants, unless: -> draw { draw.previous_draw.nil? }

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

      pickee_permutations = participants.map(&:id).permutation.to_a
      pickee_permutations.shuffle!

      pickee_permutations.each do |pickees|
        if valid_picks?(pickers, pickees)
          store(pickers, pickees)
          break
        end
        logger.error "###### NOT FOUND"

      end

      self.drawn = true
      self.drawn_on = Time.now
      save
    end
  end

  def valid_picks?(pickers, pickees)
    pickers.each_with_index do |picker, i|
      return false if picker == pickees[i]
      return false if same_as_previous_pick(picker, pickees[i])
    end
    logger.error "###### FOUND"
    true
  end

  def store(pickers, pickees)
    pickers.each_with_index do |picker, i|
      pickee = pickees[i]
      Pick.create!(:picker_id => picker, :picked_id => pickee, draw_id: id)
    end
  end

  def same_as_previous_pick(picker, pickee)
    return false unless previous_draw

    current_picker = Participant.find(picker)
    current_pickee = Participant.find(pickee)

    previous_picker = previous_draw.participants.where(email: current_picker.email).first
    previous_picker.pick.picked.email == current_pickee.email
  end

  ### Tests the making process ###
  def test
    10000.times do |i|
      puts "try #{i}"
      picks = make
      puts picks.inspect
      picks.each do |picker, pickee|
        raise "Invalid found" if picker == pickee
        raise "Invalid found (previous)" if previous_pick_for(picker) == pickee
      end
    end
  end

  ### emails all participants a link to their draw
  def email_participants
    participants.each(&:email_pick)
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
