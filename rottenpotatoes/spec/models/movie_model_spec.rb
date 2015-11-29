require 'spec_helper'
require 'rails_helper'

describe Movie do

 before :each do
   Movie.create(title: 'Movie1', rating: 'PG', description: 'Test movie1', release_date: Time.now, director: 'Guy1')
   Movie.create(title: 'Movie2', rating: 'PG', description: 'Test movie2', release_date: Time.now, director: 'Guy2')
   Movie.create(title: 'Movie3', rating: 'PG-13', description: 'Test movie3', release_date: Time.now, director: 'Guy1')
 end
 context 'Searching for a movie' do
   it 'should find a movie based on an existing movies director' do
     expect(Movie.search_by_movie_director('Guy1').count).to eq(2)
   end 

   it 'should not find movies by different directors' do
     Movie.search_by_movie_director('Guy1').each do | movie|
       expect(movie.director).not_to eq('Guy2')
     end
   end
 end
end
