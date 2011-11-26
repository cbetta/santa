class PicksController < ApplicationController
  skip_before_filter :require_login
  
  ### shows the pick and marks it as viewed ###
  def show
    @pick = Pick.find_by_hash(params[:id])
    @pick.update_attribute(:has_checked, true) unless @pick.has_checked
    
    redirect_to root_url, alert: "Access denied" if @pick.nil?
  end
  
  
end
