class ParticipantsController < ApplicationController

  def create
    @draw = current_user.draws.find(params[:participant][:draw_id])
    redirect_to @draw, alert: "This draw has already been made." if @draw.drawn
    
    @participant = @draw.participants.build(params[:participant])
    @participant.save
  end

  def destroy
    @participant = Participant.find(params[:id])
    redirect_to @participant.draw, alert: "This draw has already been made." if @participant.draw.drawn
    
    redirect_to root_url, alert: "Access denied" if @participant.draw.user != current_user
    
    @participant.delete
  end
end
