class AddColumnIsBotToNewsMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :news_messages, :is_bot, :boolean, default: false
  end
end
