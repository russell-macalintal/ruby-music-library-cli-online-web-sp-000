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
      case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      end

      call
    end

  end

  def list_songs
    sorted = Song.all.sort_by {|song| song.name}
    sorted.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted = Artist.all.sort_by {|artist| artist.name}
    sorted.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted = Genre.all.sort_by {|genre| genre.name}
    sorted.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    sel_artist = Artist.find_by_name(input)
    if !sel_artist.nil?
      sorted = sel_artist.songs.sort_by {|song| song.name}
      sorted.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.strip
      sel_genre = Genre.find_by_name(input)
      if !sel_genre.nil?
        sorted = sel_genre.songs.sort_by {|song| song.name}
        sorted.each_with_index do |song, index|
          puts "#{index + 1}. #{song.artist.name} - #{song.name}"
        end
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      input = gets.strip
      integer = input.to_i
      sorted = Song.all.sort_by {|song| song.name}
      if integer >= 1 && integer <= Song.all.size
        puts "Playing #{sorted[integer - 1].name} by #{sorted[integer - 1].artist.name}"
      end
    end

  end

end
