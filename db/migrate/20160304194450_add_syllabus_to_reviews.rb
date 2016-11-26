class AddSyllabusToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :syllabus, :string
  end
end
