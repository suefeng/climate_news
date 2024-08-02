class CreateNewsMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :news_messages, id: :uuid do |t|
      t.json :message_body
      t.boolean :is_chatbot
      t.references :news_thread, type: :uuid, foreign_key: true, null: false

      t.timestamps
    end
  end
end
