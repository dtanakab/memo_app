# frozen_string_literal: true

require 'pg'

# Read or write or remove txt file
class Memo
  @conn = PG.connect(dbname: 'sinatra_training')

  class << self
    def index
      @conn.exec('SELECT id FROM memo')
    end

    def write(text)
      @conn.exec("INSERT INTO memo VALUES (nextval('id'), $1)", [text])
    end

    def update(id, text)
      @conn.exec('UPDATE memo SET memo = $1 WHERE id = $2', [text, id])
    end

    def read(id)
      @conn.exec("SELECT memo FROM memo WHERE id = #{id}")[0]['memo']
    end

    def delete(id)
      @conn.exec("DELETE FROM Memo WHERE id = #{id}")
    end
  end
end
