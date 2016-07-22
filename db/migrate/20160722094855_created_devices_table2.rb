class CreatedDevicesTable2 < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :device_id
      t.integer :user_id
      t.string :registration_id
      t.integer	 :device_guid
      t.string :device_os
      t.datetime :created_at
      t.string :osVersion
      t.datetime :device_time_zone
      t.string :sdkVersion
      t.string :device_name

      t.timestamps null: false
    end
  end
end
