class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:update, :destroy]

  # GET /favorites
  def index
    @favorites = Favorite.all

    render json: @favorites
  end

  # GET /favorites/1
  def show
    # p params
    @favorite = Favorite.where({activity_id: params[:id], user_id:@user.id}).first()
    render json: @favorite
  end

  ##returns status of false if there is no favorite as a result, else returns true and a favorite
  def toggle
    p params
    @favorite = Favorite.where({activity_id: params[:id], user_id:@user.id}).first()
    p @favorite
    if @favorite
      @favorite.destroy()
      render json: {
          status: false
      }
    else
      # param = favorite_params #don't uncomment this unless this request should have a body
      @favorite = Favorite.new(activity_id: params[:id], user_id: @user[:id])

      if @favorite.save
        render json: {
            fav: @favorite,
            status:true}
      else
        render json: {
            status:false,
            error: @favorite.errors
        }
      end
    end
  end

  # POST /favorites
  def create
    param = favorite_params
    @favorite = Favorite.new(activity_id: param[:activity_id], visited: param[:visited], user_id: @user[:id])

    if @favorite.save
      render json: @favorite, status: :created, location: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favorites/1
  def update
    if @favorite.update(favorite_params)
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    if (@favorite.user_id == @user.id)
      render json: {
          deleted: @favorite.destroy
      }
    else
      render json:{
          "message":"This favorite does not belong to you"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def favorite_params
      params.require(:favorite).permit( :activity_id, :visited)
    end
end
