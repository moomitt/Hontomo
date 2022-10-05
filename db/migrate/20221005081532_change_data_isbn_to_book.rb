class ChangeDataIsbnToBook < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :isbn, :string
  end
end
