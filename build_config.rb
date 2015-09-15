MRuby::Build.new do |conf|
  toolchain :gcc
  enable_test

  conf.gembox 'default'
  conf.gem '../'
end
