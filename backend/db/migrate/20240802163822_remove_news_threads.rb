class RemoveNewsThreads < ActiveRecord::Migration[7.1]
  def change
    drop_table :news_threads
  end
end
