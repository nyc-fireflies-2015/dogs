class AddUpvotesToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :likes, :integer, default: 0
  end
end
