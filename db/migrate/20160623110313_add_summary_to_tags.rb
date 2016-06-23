class AddSummaryToTags < ActiveRecord::Migration
  def change
    add_column :tags, :summary, :text, default: "Summary goes here."
  end
end

#Default should be changed to null false once seeds are updated
