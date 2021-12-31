class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.datetime :when
      t.string :zoom_link
      t.string :zoom_code
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
