class Song
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

  # def artist=(artist)
  #   if self.artist != artist
  #     @artist = artist
  #     artist.add_song(self) unless artist.songs.include? (self)
  #   end
  # end

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

end
