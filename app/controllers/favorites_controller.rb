class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @user = current_user
    @movie.fans << @user unless @user.favorites.find_by(movie_id: @movie.id)

    redirect_to movie_url(@movie)
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
