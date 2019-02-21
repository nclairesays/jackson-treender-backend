class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :user1
      t.integer :user2
      t.boolean :user1_response
      t.boolean :user2_response

      t.timestamps
    end
  end
end
