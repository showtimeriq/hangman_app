class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.text :name
      t.integer :remaining_num_guesses 
      t.text :guessed_letters
      t.timestamps
    end
  end
end
