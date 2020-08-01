# Rails.application.routes.draw do
#   resources :artists do
#     resources :songs, only: [:index, :show, :new, :edit, :create]
#     #artists/artist_id/songs
#     #artist_songs_path
#   end
#   resources :songs
# end

Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:index, :show, :new, :edit]
  end
  resources :songs
end
