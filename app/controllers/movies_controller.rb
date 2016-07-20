class MoviesController < ApplicationController

  # scope :title_search, -> { where("title LIKE ?", "%#{params[:title]}%") }
  # scope :director_search, -> { where("director LIKE ?", "%#{params[:director]}%") }
  # scope :duration_search, -> { where("runtime_in_minutes #{params[:runtime_in_minutes]}") unless params[:runtime_in_minutes].nil?  }


  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    # @movie.runtime_in_minute = @movie.runtime_in_minute.to_i

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def search
    # @ss = params
    # @movies = Movie.where("title LIKE ?", "%#{params[:title]}%")
    # @movies = @movies.where("director LIKE ?", "%#{params[:director]}%")
    # unless params[:runtime_in_minutes].nil?
    #   @movies = @movies.where("runtime_in_minutes #{params[:runtime_in_minutes]}")
    # end

    # binding.pry
    @movies = Movie.search_word(params[:search]).duration(params[:runtime_in_minutes])


    # @movies = Movie.title(params[:title]).director(params[:director]).duration(params[:runtime_in_minutes])

    render :index
  end

  protected

    def movie_params
      params.require(:movie).permit(
        :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
      )
    end
end





