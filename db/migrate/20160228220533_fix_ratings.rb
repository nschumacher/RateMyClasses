class FixRatings < ActiveRecord::Migration
  def change
  	add_column :courses, :ratings, :integer, :default => 0	
  end
end
