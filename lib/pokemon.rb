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
  
  def self.find
    sql = <<-SQL
      SELECT*
      FROM pokemon
      WHERE id = ?
    SQL
    
    db.execute(sql, self.id).map do |row|
      self.new_from_db(row)
    end
  end
  
  def self.create(row)
    pokemon = self.new(name: row[1], type: row[2] )
    pokemon.id = row[0]
    pokemon
  end
  

end
