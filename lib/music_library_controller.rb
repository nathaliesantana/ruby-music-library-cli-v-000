require 'pry'
class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      # Ask the user for input======================>
      input = gets.strip

    end
  end

  def list_songs
    song_list= Song.all.sort{|a,b| a.name <=> b.name}
    n = 1
    song_list.each do |s|
      puts "#{n}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
      n += 1
    end
  end

  def list_artists
    artist_list= Artist.all.sort{|a,b| a.name <=> b.name}
    n = 1
    artist_list.each do |s|
      puts "#{n}. #{s.name}"
      n += 1
    end
  end

  def list_genres
    genre_list= Genre.all.sort{|a,b| a.name <=> b.name}
    n = 1
    genre_list.each do |s|
      puts "#{n}. #{s.name}"
      n += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip

    if list = Artist.find_by_name(user_input)
      artists_songs = list.songs.sort{|a,b| a.name <=> b.name}
      n = 1
      artists_songs.each do |s|
        puts "#{n}. #{s.name} - #{s.genre.name}"
        n += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.strip

    if list = Genre.find_by_name(user_input)
      genre_songs = list.songs.sort{|a,b| a.name <=> b.name}
      n = 1
      genre_songs.each do |s|
        puts "#{n}. #{s.artist.name} - #{s.name}"
        n += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input= gets.strip.to_i
    if Song.all.length <= user_input-1
      song = Song.all.sort{ |a, b| a.name <=> b.name }[user_input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}"

  end



end
