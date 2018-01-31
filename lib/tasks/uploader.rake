namespace :upload_data do
  desc "Uploading excel sheet of the bugs"
  task updload_bugs: :environment do
  	require 'csv'
   csv_text = File.read(Rails.root.join('lib', 'tasks', 'bugs.csv'))
   csv    = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

   csv.each do |row|
    Task.transaction do 
      if !row['Description'].nil?
        task = Task.new
        task['description'] = row['Description']
        task['created_at']  = Time.now
        task['dev_status']  = row['Developer Status'].to_i
        task['product_type'] = row['Product Type'].to_i
        task['environment'] = row['Environment'].to_i
        task['assigned_to'] = row['assigned to'].to_i
        task['category'] = row['Category'].to_i
        task['qa_status'] = row['QA Status'].to_i
        task['completed_at']  = row['Solved at']
        task['level'] = row["Level"]
        task['reported_by'] = row['Reported by'].to_i
        task['reported_at'] = row['Reported At']
        task['started_at']  = row['Assigned at']
        task['time_taken'] = ((task['completed_at'] - task['started_at'])/60).to_i if !task['completed_at'].nil? && !task['started_at'].nil?
        task.save!
        if task['assigned_to'] != 0
          user = User.find_by(email: task['assigned_to'] + '@augmentcare.com')
          if !user.nil?
            task.update(user_id: user.id)
          end
        end

      end
    end
  end
end
end