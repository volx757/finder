class AddTagsToUsersAndWorks < ActiveRecord::Migration
  def change
    add_column :users, :city, :string

    add_column :users, :tags, :string
    add_column :works, :tags, :string
  end
end
