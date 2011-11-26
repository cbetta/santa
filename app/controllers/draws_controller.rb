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

  # GET /draws/1/edit
  def edit
    @draw = current_user.draws.find(params[:id])
  end

  # POST /draws
  # POST /draws.json
  def create
    @draw = current_user.draws.build(params[:draw])

    respond_to do |format|
      if @draw.save
        format.html { redirect_to @draw, notice: 'Draw was successfully created.' }
        format.json { render json: @draw, status: :created, location: @draw }
      else
        format.html { render action: "new" }
        format.json { render json: @draw.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /draws/1
  # PUT /draws/1.json
  def update
    @draw = current_user.draws.find(params[:id])

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
    @draw.destroy

    respond_to do |format|
      format.html { redirect_to draws_url }
      format.json { head :ok }
    end
  end
end
