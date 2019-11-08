require 'pry'

class Artist
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genres = []
    self.songs.each {|song| genres << song.genre}
    genres.uniq
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
    artist = self.new(name)
    artist.save
    artist
  end

  # def add_song(song)
  #   if song.artist.nil? || song.artist.class != Artist
  #     self.songs << song
  #     song.artist = self
  #   end
  # end

  def add_song(song)
    self.songs << song if !self.songs.include?(song)
    song.artist = self if song.artist.nil?
  end

end
