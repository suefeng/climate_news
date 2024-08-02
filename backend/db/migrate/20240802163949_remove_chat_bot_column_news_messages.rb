class RemoveChatBotColumnNewsMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :news_messages, :is_chatbot
  end
end
