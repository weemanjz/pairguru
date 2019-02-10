class TopCommentersFinder
  def call(from: 7.days.ago, limit: 10)
    @from = from
    @limit = limit
    ActiveRecord::Base.connection.exec_query(sql).to_hash
  end

  private

  def sql
    <<-SQL
      SELECT users.id, users.name, COUNT(*) AS comments_count
      FROM users
      JOIN comments
      ON users.id = comments.user_id
      WHERE comments.created_at > "#{@from}"
      GROUP BY users.id
      ORDER BY comments_count DESC
      LIMIT #{@limit};
    SQL
  end
end
