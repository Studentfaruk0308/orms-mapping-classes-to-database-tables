require 'sqlite3'



class Song
    attr_accessor :name, :album, :id
    @@all = []
    @@database_connection = SQLite3::Database.new('/home/faruk/Development/Code/Phase-3/orms-mapping-classes-to-database-tables/song.db')

    def initialize(id=nil, name, album)
      @id = id
      @name = name
      @album = album
      @@all << self
      
    end
  
    def self.all
        @@all
    end

    def self.create_table()
        sql =  <<-SQL 
          CREATE TABLE IF NOT EXISTS songs (
            id INTEGER PRIMARY KEY, 
            name TEXT, 
            album TEXT
            )
            SQL
            @@database_connection.execute(sql) 
    end
  
    def save
    #     sql = <<-SQL
    #     INSERT INTO songs (name, album) 
    #     VALUES (?, ?)
    #   SQL
  
      @@database_connection.execute("INSERT INTO songs (name, album) VALUES (?, ?)", self.name, self.album)

    #   @id = database_connection.execute("SELECT last_insert_rowid() FROM songs")[0][0]
  
    end
  
    def self.create(name:, album:)
        song = Song.new(name, album)
        song.save
        song
      end
  end

  Song.create_table;
#   Song.new("Hello", "25");
#   Song.new("99 Problems", "The Black Album");
  Song.create({name: "New Song4", album: "New Album4"});

#   Song.all.each do |song|
#     Song.save(song.name, song.album)
#   end
  
  
