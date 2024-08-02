class ChangeColumnNews < ActiveRecord::Migration[7.1]
  def change
    remove_column :news, :news_updated_at
    add_column :news, :published_at, :datetime

    add_column :news, :site_name, :string
  end
end
