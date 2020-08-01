# class SongsController < ApplicationController
#   before_action :set_artist, only: [:index, :show, :new, :edit, :create]
#   def index
#     if params[:artist_id] && !@artist
#         redirect_to artists_path, alert: "Artist not found"
#     elsif @artist
#         @songs = @artist.songs
#     else
#         @songs = Song.all
#     end

#     # if params[:artist_id]
#     #   @artist = Artist.find_by(id: params[:artist_id])
#     #   if @artist.nil?
#     #     redirect_to artists_path, alert: "Artist not found"
#     #   else
#     #     @songs = @artist.songs
#     #   end
#     # else
#     #   @songs = Song.all
#     # end
#   end

#   def create 
#     if @artist
#       @song = @artist.songs.new(song_params)
#     else 
#       @song = Song.new(song_params)
#     end 
#     if @song.save 
#       redirect_to @song
#     else 
#       render :new
#     end 
#   end 

#   def show
#     #if there is an artist and a song both correctly given
#     #set song and show the show page
#     #elseif theres an artist and the song is incorrect go to the artist
#     #else go to the list of all songs
#     # if params[:artist_id]
#     #   @artist = Artist.find_by(id: params[:artist_id])
#     #   @song = @artist.songs.find_by(id: params[:id])
#     #   if @song.nil?
#     #     redirect_to artist_songs_path(@artist), alert: "Song not found"
#     #   end
#     # else
#     #   @song = Song.find(params[:id])
#     # end
#     if @artist
#       # flash[:alert] = "We are not in the artist path"
#       @song = @artist.songs.find_by(id: params[:id])
#       if @song.nil?
#         redirect_to artist_songs_path(@artist), alert: "Song not found"
#         end
#       else 
#         # flash[:alert] = "We are not in the artist path"
#         @song = Song.find(params[:id])
#      end
#   end

#   def new 
#     if params[:artist_id]
#       unless @artist
#         redirect_to artists_path
#       else 
#         @song = @artist.songs.build
#       end 
#     # if @artist
#     #   @song = @artist.songs.build
#     #   #associated with an artist -- might have an artist_id
#     else 
#       @song = Song.new
#     end
#   end

#   def create
#     @song = Song.new(song_params)

#     if @song.save
#       redirect_to @song
#     else
#       render :new
#     end
#   end

#   def edit
#     @song = Song.find(params[:id])
#   end

#   def update
#     @song = Song.find(params[:id])

#     @song.update(song_params)

#     if @song.save
#       redirect_to @song
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @song = Song.find(params[:id])
#     @song.destroy
#     flash[:notice] = "Song deleted."
#     redirect_to songs_path
#   end




#   private

#   def song_params
#     params.require(:song).permit(:title, :artist_name)
#   end

#   def set_artist
#     @artist = Artist.find_by(id: params[:artist_id])
#   end

# end

class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: "Artist not found."
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
      if artist.nil?
        redirect_to artists_path, alert: "Artist not found."
      else
        @song = artist.songs.find_by(id: params[:id])
        redirect_to artist_songs_path(artist), alert: "Song not found." if @song.nil?
      end
    else
    @song = Song.find(params[:id])
    end
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end