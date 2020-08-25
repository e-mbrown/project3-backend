class ActivityController < ApplicationController
  before_action :authorized

  def index
    @activity_list = Activity.all
    if @activity_list.empty?
      render json: {
          'error': 'oops there is no Activity to show'
      }
    else
      render :json => {
          :response => 'successful',
          :data => @activity_list
      }
    end
  end

  # Show activities by city
  def activity_by_location
    @location = :location
    @activity_by_city = Activity.where({location: params[:location]})
    if @activity_by_city
      render :json => {
          :data => @activity_by_city
      } else {
        :error => 'No activites found for this city.'
    }
    end
  end

  #creates new activity for the user(profile) from API
  def create
    @one_activity = Activity.new(activity_params)
    if @one_activity.save
      render :json => {
          :response => 'successfully created the activity',
          :data => @one_activity
      }
    else
      render :json => {
          :error => 'cannot save the data'
      }
    end
  end

  #Read - show all activities on wishlist
  def show
    @one_activities = Activity.exists?(params[:id])
    if @one_activities
      render :json => {
          :response => 'successful',
          :data => Activity.find(params[:id])
      }
    else
      render :json => {
          :response => 'activity not found'
      }
    end
  end

  #Update - updated if you visited the activity (patch request just for isVisited)
  def update
    if(@add_activity_update = Activity.find_by_id(params[:id])).present?
      @add_activity_update.update(activity_params)
      render :json => {
          :response => 'successfully update the activity data',
          :data => @add_activity_update
      }
    else
      render :json => {
          :response => 'cannot update the selected activity'
      }
    end
  end

  #Delete - delete activity from profile
  def destroy
    if (@activity_delete = Activity.find_by_id(params[:id])).present?
      @activity_delete.destroy
      render :json => {
          :response => 'successfully deleted the activity'
      }
    else
      render :json => {
          :response => 'cannot delete the selected activity'
      }
    end
  end


  private
  def activity_params
    params.permit( :id, :name, :location, :address)
  end

end
