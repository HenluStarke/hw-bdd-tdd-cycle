require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  before :all do
    @fake_results = [double('Movie'), double('Movie')] 
  end
  describe 'searching movies by director' do
    it 'should find movies with the same director as the current movie' do
     @fake_movie = double('Movie', :director => 'fake director', :id => 1)
     Movie.stub(:search_by_movie_director).and_return(@fake_results)
     Movie.stub(:find).and_return(@fake_movie)
     get :search_by_movie_director, :id => 1
     assigns(:movies).should == @fake_results
    end
    it 'should show an alert if no similar directors as the current movie were found' do
      pending
    end
  end
end
