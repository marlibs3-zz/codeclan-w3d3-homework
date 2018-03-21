require('pg')
require_relative('../SqlRunner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def self.drop()
    sql = "DROP TABLE IF EXISTS artists;"
    SqlRunner.run(sql)
  end

  def self.create()
    sql = "CREATE TABLE artists (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(255)
    );"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
      ) VALUES
      (
        $1
      )
      RETURNING id"
      values = [@name]
      result = SqlRunner.run(sql, values)
      @id = result[0]['id']
    end

    def self.all()
      sql = "SELECT * FROM artists;"
      artists = SqlRunner.run( sql )
      return artists.map { |artist| Artist.new( artist ) }
    end

    def pizza_orders()
      sql = "SELECT * FROM pizza_orders
      WHERE customer_id = $1"
      values = [@id]
      results = SqlRunner.run( sql, values )
      orders = results.map { |order| PizzaOrder.new( order ) }
      return orders
    end

    def pizza_orders()
      sql = "SELECT * FROM pizza_orders
      WHERE customer_id = $1"
      values = [@id]
      results = SqlRunner.run( sql, values )
      orders = results.map { |order| PizzaOrder.new( order ) }
      return orders
    end

  end
