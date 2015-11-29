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
    it 'should redirect the user to the home page and alert when the movie has no director' do
     @fake_movie = double('Movie', :id => 1, :director => nil, title: 'Fake movie')
     Movie.stub(:search_by_movie_director).and_return(nil)
     Movie.stub(:find).and_return(@fake_movie)
     get :search_by_movie_director, :id => 1
     assigns(:movies).should == nil
     expect(response).to redirect_to(movies_path)
     expect(flash[:notice]).to be_present
    end
  end
end
