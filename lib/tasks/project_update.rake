namespace :project do
    desc "Runs scripts to make sure the app can work after a git update"
    task :update do
        Rake::Task["db:update"].invoke
        exec "bundle install"
    end
end