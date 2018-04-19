Gem::Specification.new do |s|
  s.name        = 'mtg'
  s.version     = '0.0.0'
  s.date        = '2018-04-06'
  s.summary     = "Test code for LingoKids"
  s.description = "A simple hello world gem"
  s.authors     = ["Fran Martinez"]
  s.email       = 'martinezcoder@gmail.com'
  s.files       = ["lib/mtg.rb",
                  "lib/mtg/mtg_set.rb",
                  "lib/mtg/api_client.rb",
                  "lib/mtg/retryable.rb",
                  "lib/mtg/card.rb",
                  "lib/mtg/downloader.rb"]
  s.executables << 'lk_cards'
  s.homepage    = 'http://www.martinezcoder.com'
  s.license     = 'MIT'

  s.add_development_dependency "bundler", "~> 1.14"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
end
