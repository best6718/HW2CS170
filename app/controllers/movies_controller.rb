class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  #March 9th HW2 1.b
  def index
    #@movie = Movie.all
    @movies = Movie.order(params[:sort])
    if params[:sort] == 'title'
      @title_header = 'hilite'
    elsif params[:sort] == 'release_date'
      @release_header = 'hilite'
    end
    #order all the movies
  end

  # def new
  #   # default: render 'new' template
  # end

  # replaces the 'create' method in controller:
  def create
    #@movie = Movie.new(params[:movie])
    
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new' # note, 'new' template can access @movie's field values!
    end
  end

# replaces the 'update' method in controller:
  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end

# note, you will also have to update the 'new' method:
  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find params[:id]
  end

  #def update
    # @movie = Movie.find params[:id]
    # @movie.update_attributes!(movie_params)
    # flash[:notice] = "#{@movie.title} was successfully updated."
    # redirect_to movie_path(@movie)
 # end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date, :timestamps)
  end

end
