Gem::Specification.new do |spec|
  spec.name        = 'locality'
  spec.version     = '1.1.0'
  spec.date        = '2016-11-14'
  spec.summary     = "Wrapping databases provided by maxmind.com and postnummerservice.se"
  spec.description = "See https://github.com/bukowskis/locality"
  spec.authors     = %w{ bukowskis }
  spec.homepage    = 'https://github.com/bukowskis/locality'

  spec.files       = Dir['{bin,lib,man}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")

  spec.add_dependency 'activesupport'
  spec.add_dependency 'geocoder', '1.2.13'
  spec.add_dependency 'hashie'
  spec.add_dependency 'maxminddb', '0.1.8'
  spec.add_dependency 'i18n'
  spec.add_dependency 'operation'
  spec.add_dependency 'trouble'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rb-fsevent'
  spec.add_development_dependency 'webmock'
end
