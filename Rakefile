file :mruby do
  sh 'git clone --depth=1 git://github.com/mruby/mruby.git'
end

file :build_config do
  cp 'build_config.rb', 'mruby/build_config.rb'
end

desc 'test'
task :test => [:mruby, :build_config] do
  sh 'cd mruby && rake all test'
end

desc 'cleanup'
task :clean do
  sh 'cd mruby && rake deep_clean'
end

task :default => :test
