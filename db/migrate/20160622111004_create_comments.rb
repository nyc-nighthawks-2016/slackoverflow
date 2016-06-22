class CreateComments < ActiveRecord::Migration
  def change
      create_table :comments do |t|
        t.text     :comment, null:false
        t.references :user, index: true
        t.references :commentable, polymorphic: true, index: true

        t.timestamps(null: false)
    end
  end
end
