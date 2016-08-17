class RemoveNotableJobs < ActiveRecord::Migration
  def change
    drop_table :notable_requests
    drop_table :notable_jobs
  end
end
