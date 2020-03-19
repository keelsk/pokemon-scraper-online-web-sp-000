require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db
  
  def initialize(id: nil, name:, type:, db:)
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES(?, ?)
    SQL
    
    db.execute(sql, name, type)
    
    @id = db.execute("SELECT last_insert_rowid()")[0][0]
  end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT*
      FROM pokemon
      WHERE id = ?
    SQL
    
    db.execute(sql, id).map do |row|
      self.create(row, db)
    end.first
  end
  
  def self.create(row, db)
    pokemon = self.new(name: row[1], type: row[2], db: db)
    pokemon.id = row[0]
    pokemon
    binding.pry
  end
  

end
