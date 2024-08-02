class CreateNewsMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :news_messages do |t|
      t.json :message_body
      t.boolean :is_chatbot
      t.references :news_thread, null: true

      t.timestamps
    end
  end
end
