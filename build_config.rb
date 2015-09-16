MRuby::Build.new do |conf|
  toolchain :gcc
  conf.gem File.expand_path(File.dirname(__FILE__))
end

MRuby::Build.new('test') do |conf|
  toolchain :gcc

  enable_debug
  conf.enable_test

  conf.gembox 'default'
  conf.gem File.expand_path(File.dirname(__FILE__))
end
