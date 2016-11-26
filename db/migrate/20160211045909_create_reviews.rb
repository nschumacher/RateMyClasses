class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :UserID
      t.integer :CourseID
      t.text :Comment
      t.integer :HelpfulCount
      t.integer :Unhelpful
      t.integer :FunnyCount
      t.integer :FlagCount
      t.string :Instructor
      t.string :TAs
      t.integer :GradeReceived
      t.integer :HoursAWeek
      t.boolean :TextbookRequired
      t.boolean :AttendanceRequired
      t.string :Semester
      t.integer :YearTaken
      t.integer :DepartmentID

      t.timestamps null: false
    end
  end
end
