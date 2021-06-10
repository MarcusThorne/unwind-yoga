class RemoveColumnsFromSessions < ActiveRecord::Migration[6.0]
  def change
    remove_column :sessions, :until
    remove_column :sessions, :reocurring
  end
end
