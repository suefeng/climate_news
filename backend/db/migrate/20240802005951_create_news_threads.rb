class CreateNewsThreads < ActiveRecord::Migration[7.1]
  def change
    create_table :news_threads, id: :uuid do |t|
      t.string :run_id
      t.string :thread_id
      t.json :initial_query

      t.timestamps
    end
  end
end
