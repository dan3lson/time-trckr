class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string     :name,       null: false
      t.datetime   :started_at, null: false
      t.datetime   :stopped_at, null: false

      t.timestamps null: false
    end
  end
end
