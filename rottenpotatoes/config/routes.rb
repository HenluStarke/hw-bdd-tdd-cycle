Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do
      get 'search_by_movie_director'
    end
  end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
