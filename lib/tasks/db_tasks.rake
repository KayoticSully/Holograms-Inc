namespace :db do
    desc "Resets the database and brings it up to the newest schema"
    task :update do
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        Rake::Task["db:schema:load"].invoke
    end
    
#    desc "Loads database defaults
#    task :defaults do
#        require 'csv'
#        
#        filename = "../../db/defaults.csv"
#        
#        CSV.foreach(filename, :headers => true) do |row|
#            Moulding.create!(row.to_hash)
#        end
#    end
end