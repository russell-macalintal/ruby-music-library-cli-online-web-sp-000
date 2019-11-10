require_relative './concerns/Findable.rb'

class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist.class == Artist
      self.artist = artist
    end
    if genre.class == Genre
      self.genre = genre
    end
  end

  def artist=(artist)
    if self.artist.class != Artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if !genre.songs.include? (self)
      @genre = genre
      genre.songs << self
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  # def self.find_by_name(name)
  #   self.all.detect {|song| song.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name).nil? ? self.create(name) : self.find_by_name(name)
  # end

  def self.new_from_filename(filename)
    if self.find_by_name(filename.split(" - ")[1]).nil?
      song = self.new(filename.split(" - ")[1])
      song.artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
      song.genre = Genre.find_or_create_by_name(filename.split(" - ")[2].chomp(".mp3"))
      song
    end
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end

end
