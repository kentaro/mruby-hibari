MRuby::Gem::Specification.new('mruby-hibari') do |spec|
  spec.license = 'MIT'
  spec.author  = 'Kentaro Kuribayashi'
  spec.summary = 'A Web Application Framework'

  spec.add_dependency 'mruby-uri', github: 'zzak/mruby-uri'
end
