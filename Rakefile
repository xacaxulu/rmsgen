require 'bundler'

Bundler::GemHelper.install_tasks

task :default => [:spec, :features]

task :spec do
  system 'rspec spec'
end

task :features do
  system 'cucumber features'
end
