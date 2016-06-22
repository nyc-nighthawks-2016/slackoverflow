class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string   :subject, null:false, limit: 24

      t.timestamps(null:false)
    end
  end
end
