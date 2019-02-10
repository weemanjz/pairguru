class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.create(comment_params.merge(user: current_user, movie: movie))
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], user: current_user, movie: movie)
                      &.destroy
  end

  private

  def movie
    @movie ||= Movie.find(params[:movie_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
