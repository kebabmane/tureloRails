class RemoveNotableJobs < ActiveRecord::Migration[4.2]
  def change
    drop_table :notable_requests
    drop_table :notable_jobs
  end
end
