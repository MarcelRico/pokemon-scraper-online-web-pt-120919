class Pokemon
  
  @@all = []
  
  attr_reader :id
  attr_accessor :name,:type,:db
  
  def initialize(attributes)
    @id = attributes["id"]
    @name = attributes["name"]
    @type = attributes["type"]
    @db = attributes["db"]
  end
  
  def self.save(name,type,db)
    sql = <<-SQL
      INSERT INTO pokemon (name,type) VALUES (?,?)
    SQL
    
    db.execute(sql,name,type);
  
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0];
    #return id
  end
  
  def self.create_from_db(row)
    id = row[0][0]
    name = row[0][1]
    type = row[0][2]
    self.new(id:id,name:name,type:type);
  end
  
  def self.find(id,db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE pokemon.id = ?
    SQL
    
    row = db.execute(sql,id)
    create_from_db(row)
  end
  
end