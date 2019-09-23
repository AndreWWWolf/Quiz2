class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :body

      t.timestamps
    end
    add_reference :reviews, :idea, foreign_key: true
  end
end
