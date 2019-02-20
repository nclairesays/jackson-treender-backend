class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :user1
      t.string :user1_response
      t.string :user2
      t.string :user2_response

      t.timestamps
    end
  end
end
