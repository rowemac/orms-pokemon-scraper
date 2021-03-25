require 'pry'

class Pokemon

    attr_accessor :db, :name, :type, :id

    def initialize (db:, name:, type:, id:)
        @db = db
        @name = name
        @type = type
        @id = id
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL
        db.execute(sql, name, type)

        @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]

    end 

    def self.find(id, db)
        
        sql = "SELECT * FROM pokemon WHERE id = ?"
        results = db.execute(sql, id)[0]
        pokemon = Pokemon.new(id: id, name: results[1], type: results[2], db: db)
    end

end
