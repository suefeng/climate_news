class RemoveThreadIdFromNewsMessage < ActiveRecord::Migration[7.1]
  def change
    remove_column :news_messages, :news_thread_id
  end
end
