require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  before :all do
    @fake_results = [double('Movie'), double('Movie')] 
    @time = Time.now
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
  describe 'create a movie' do
    it 'should create a new movie and redirect to home on success with a notice' do
     fake_movie = double('Movie', :id => 1, :director => 'Guy1', title: 'Fake movie', rating: 'PG', :description => 'tester', :release_date => @time)
     Movie.stub(:create!).and_return(fake_movie)
     get :create, :movie =>{:title => 'Fake movie', :rating => 'PG', :decription => 'tester', :release_date => @time, :director => 'Guy1'}
     assigns(:movie).should == fake_movie
     expect(response).to redirect_to(movies_path)
     expect(flash[:notice]).to be_present
    end
  end
  describe 'update a movie' do
    it 'should update an existing movie with new details and post a success notice' do
     fake_movie = double('Movie', {:id => 1, :director => 'Guy1', title: 'Fake movie', rating: 'PG', :description => 'tester', :release_date => @time})
     fake_updated_movie = double('Movie',{:id => 1, :director => 'Guy1', title: 'Fake movie', rating: 'PG-13', :description => 'tester', :release_date => @time})
     Movie.stub(:find).and_return(fake_movie)
     fake_movie.stub(:update_attributes!).and_return(fake_updated_movie)
     put :update, :id =>1, :movie => {:rating => 'PG-13'}
     assigns(:movie).should == fake_movie
     expect(flash[:notice]).to be_present
     expect(flash[:notice]).to eq("#{fake_movie.title} was successfully updated.")
    end
  end
  describe 'destroy a movie' do
    it 'should destroy a movie and post a notice on success' do
     fake_movie = double('Movie', {:id => 1, :director => 'Guy1', title: 'Fake movie', rating: 'PG', :description => 'tester', :release_date => @time})
     Movie.stub(:find).and_return(fake_movie)
     fake_movie.stub(:destroy).and_return(true)
     delete :destroy, :id => 1
     assigns(:movie).should == fake_movie
     expect(flash[:notice]).to be_present
     expect(flash[:notice]).to eq("Movie '#{fake_movie.title}' deleted.")
    end
  end
end
