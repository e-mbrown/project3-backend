class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /comments by user
  def index
    @comments = Comment.where({user_id: params[:category_id]})
    if !@comments.exists?
    render json: {
        error: 'There are no available comments'
    }
    else render json: @comments
    end
  end

  # # GET /comments/1 by activity
  # def show
  #   @onecomment = activity.exists?(params[:location_id])
  # end
  #   if @onecomment
  #   render json: @comment
  # end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    if User.exists?(@comment.user_id) && Activity.exists?(@comment.activity_id)
      if @comment.save
        render json: @comment, status: :created, location: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: {
          error: 'User or activity does not exist'
      }
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:message, :user_id, :activity_id)
    end
end
