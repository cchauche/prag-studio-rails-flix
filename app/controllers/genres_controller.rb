class GenresController < ApplicationController
  before_action :require_signin
  before_action :require_admin

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find_by!(slug: params[:id])
    @movies = @genre.movies
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: "New genre created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    genre = Genre.find_by!(slug: params[:id])
    genre.destroy
    redirect_to genres_url, alert: "Genre deleted!"
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
