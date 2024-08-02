class CreateNews < ActiveRecord::Migration[7.1]
  def change
    create_table :news, id: :uuid do |t|
      t.string :title
      t.text :summary
      t.string :url
      t.json :images

      t.timestamps
    end
  end
end
