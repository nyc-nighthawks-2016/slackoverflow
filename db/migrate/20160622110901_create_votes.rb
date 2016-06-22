class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.references :votable, polymorphic: true, index: true
      t.integer    :vote_value

      t.timestamps(null: false)
    end
  end
end
