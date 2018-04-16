require 'pry'

class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genres = Genre.all
  end

  def create
    @song = Song.create(song_params)
    # @note_1 = Note.create(params[:song_notes_1])
    redirect_to song_path(@song)
  end

  def edit
    @song = Song.find(params[:id])
    @genres = Genre.all
  end

  def update
    # binding.pry
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
    params.require(:song).permit(:title, :artist_name, :genre_id, note_contents: [])
  end
end
