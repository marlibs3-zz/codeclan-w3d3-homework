require('pg')
require_relative('../SqlRunner')
require_relative('artist')

class Album

  attr_reader :id
  attr_accessor :name, :artist_id

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @artist_id = options['artist_id'].to_i
  end

  def self.drop()
    sql = "DROP TABLE IF EXISTS albums;"
    SqlRunner.run(sql)
  end

  def self.create()
    sql = "CREATE TABLE albums (
      id SERIAL4 PRIMARY KEY,
      name VARCHAR(255),
      artist_id  INT4 REFERENCES artists(id)
    );"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO albums
    (
      name,
      artist_id
      ) VALUES
      (
        $1, $2
      )
      RETURNING id"
    values = [@name, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    albums = SqlRunner.run( sql )
    return albums.map { |album| Album.new( album ) }
  end

end
