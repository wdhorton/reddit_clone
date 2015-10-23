class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :upvote, default: true
      t.references :votable, polymorphic: true, index: true
      t.integer :user_id, null: false

      t.timestamps null: false
    end

    add_index :votes, [:user_id, :votable_id, :votable_type], unique: true
  end
end
