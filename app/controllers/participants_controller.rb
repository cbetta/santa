class ParticipantsController < ApplicationController

  def create
    @draw = current_user.draws.find(params[:participant][:draw_id])
    @participant = @draw.participants.build(params[:participant])
    @participant.save
  end

  def destroy
    @participant = Participant.find(params[:id])
    raise "Access denied" if @participant.draw.user != current_user
    @participant.delete
  end
end
