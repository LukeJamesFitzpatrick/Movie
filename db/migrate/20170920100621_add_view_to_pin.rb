class AddViewToPin < ActiveRecord::Migration[5.1]
  def change
    add_column :pins, :view, :integer
  end
end
