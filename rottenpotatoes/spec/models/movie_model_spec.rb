require 'spec_helper'

describe 'Movies' do

 context 'Searching for a movie' do
   it 'should find a movie based on an existing movies director' do
     #Movie.find.stub({title:
     movie = Movie.find(title: 'Star Wars')
p movie
     Movie.find_same_directed_movies(movie)
    
     expect
   end 
   it 'should not find movies by different directors' do
     pending "still to implement"
   end
 end
end
