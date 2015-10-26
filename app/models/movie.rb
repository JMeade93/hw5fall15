class Movie < ActiveRecord::Base
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_in_tmdb movie
    Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')
    @matching_movies = Tmdb::Movie.find(movie)
  
    if @matching_movies.empty?
      return []
    end
    
    @movies = []
    
    @matching_movies.each do |tmdb_movie|
      @movies.push({:id => tmdb_movie.id, :title => tmdb_movie.title, :rating => "R", :release_date => tmdb_movie.release_date})
    end

    return @movies

  end
  
  def self.create_from_tmdb id
    
    Tmdb::Api.key('f4702b08c0ac6ea5b51425788bb26562')
    tmdb_movie = Tmdb::Movie.detail(id)
    
    @movie_details = Tmdb::Movie.detail(id)
    Movie.create!({title:@movie_details["title"],rating:"R",release_date:@movie_details["release_date"]})   
    
  end
  
end
