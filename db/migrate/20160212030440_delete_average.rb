class DeleteAverage < ActiveRecord::Migration
  def change
  	rename_column :courses, :average, :overallAverage
  end
end
