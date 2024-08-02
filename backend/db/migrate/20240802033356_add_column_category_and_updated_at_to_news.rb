class AddColumnCategoryAndUpdatedAtToNews < ActiveRecord::Migration[7.1]
  def change
    add_column :news, :category, :string
    add_column :news, :news_updated_at, :datetime
  end
end
