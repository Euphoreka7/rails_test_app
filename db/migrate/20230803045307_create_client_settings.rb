class CreateClientSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :client_settings do |t|
      t.references :client, null: false, foreign_key: true
      t.references :experiment, null: false, foreign_key: true
      t.references :experiment_option, null: false, foreign_key: true
      t.index [:client_id, :experiment_id], unique: true

      t.timestamps
    end
  end
end
