class ChangeSubsDescription < ActiveRecord::Migration
  def change
    change_column :subs, :description, :text
  end
end
