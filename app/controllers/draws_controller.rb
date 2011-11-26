class DrawsController < ApplicationController

  def index
    @draws = current_user.draws
  end

  def show
    @draw = current_user.draws.find(params[:id])
  end

  def new
    @draw = current_user.draws.new
  end

  def edit
    @draw = current_user.draws.find(params[:id])
    prevent_if_drawn
  end

  def create
    @draw = current_user.draws.build(params[:draw])

    if @draw.save
      redirect_to @draw, notice: 'Draw was successfully created.' 
    else
      render action: "new" 
    end
  end

  # PUT /draws/1
  # PUT /draws/1.json
  def update
    @draw = current_user.draws.find(params[:id])
    prevent_if_drawn

    respond_to do |format|
      if @draw.update_attributes(params[:draw])
        format.html { redirect_to @draw, notice: 'Draw was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draws/1
  # DELETE /draws/1.json
  def destroy
    @draw = current_user.draws.find(params[:id])
    prevent_if_drawn
    
    @draw.destroy

    respond_to do |format|
      format.html { redirect_to draws_url }
      format.json { head :ok }
    end
  end
  
  def make
    @draw = current_user.draws.find(params[:id])
    prevent_if_drawn
        
    @draw.make
    @draw.email_participants
    
    redirect_to @draw, notice: "The draw has been made and the participants have been emailed."
  end
  
private 
  
  def prevent_if_drawn
    redirect_to @draw, alert: "This draw has already been made." if @draw.drawn
  end
end
