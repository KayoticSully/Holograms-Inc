namespace :db do
    desc "Resets the database and brings it up to the newest schema"
    task :update do
        Rake::Task["db:drop"].invoke
        Rake::Task["db:create"].invoke
        Rake::Task["db:schema:load"].invoke
    end
end