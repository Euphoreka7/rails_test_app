class CreateExperimentOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :experiment_options do |t|
      t.string :value, null: false
      t.float :percentage, precision: 3, scale: 2, null: false
      t.references :experiment, null: false, foreign_key: true
      t.index [:experiment_id, :value], unique: true

      t.timestamps
    end
  end
end
