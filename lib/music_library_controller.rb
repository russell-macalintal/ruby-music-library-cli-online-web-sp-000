require 'pry'

class MusicLibraryController

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    if input == "exit"
      return true
    else
      call
    end
  end

  def list_songs
    sorted = Songs.all.sort_by {|song| song.name}
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.artist} - #{song.genre}"
    end
  end

end
