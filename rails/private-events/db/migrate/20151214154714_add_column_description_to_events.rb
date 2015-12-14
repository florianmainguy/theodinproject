class AddColumnDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :string
  end
end
