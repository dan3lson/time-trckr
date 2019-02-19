class CreateLogsTags < ActiveRecord::Migration[5.2]
  def change
    create_table :logs_tags do |t|
      t.references :log, foreign_key: true, index: true, null: false
      t.references :tag, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
