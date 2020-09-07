class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.datetime :date_apply
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
