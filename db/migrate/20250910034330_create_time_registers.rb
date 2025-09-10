class CreateTimeRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :time_registers do |t|
      t.datetime :clock_in
      t.datetime :clock_out
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
