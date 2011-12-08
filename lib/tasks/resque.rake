require 'resque/tasks'
 
task "resque:setup" => :environment
 
desc "Run Resque workers on Heroku"
task "jobs:work" => ["resque:setup"] do
  ENV['QUEUE'] = '*'
  Rake::Task["resque:work"].invoke 
end