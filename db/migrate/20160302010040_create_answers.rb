class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :answer
      t.integer :rating
      t.integer :flag
      t.integer :userID
      t.integer :question_id
      t.timestamps null: false
    end
  end
end
