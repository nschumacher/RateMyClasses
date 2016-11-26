class Deletecolumns < ActiveRecord::Migration
  def change
  	remove_column :reviews, :UserID
  	remove_column :reviews, :CourseID
  end
end
