Gem::Specification.new do |s|
  s.name        = "Paysafe"
  s.version     = "1.0.0"
  s.date        = "2014-03-11"
  s.summary     = "Paysafe API"
  s.description = "Paysafe API integration with Ruby"
  s.authors     = "Paysafe "
  s.email       = "contact@paysafe.com"
  s.homepage    = "http://www.paysafe.com/"
  s.files       = Dir["lib/*.rb"] + Dir["lib/paysafe/*.rb"] + Dir["lib/paysafe/customer_vault/*.rb"] + Dir["lib/paysafe/card_payments/*.rb"] + Dir["lib/paysafe/errors/*.rb"] + Dir["lib/paysafe/hosted_payment/*.rb"]
  s.license     = "MIT"

  s.add_development_dependency "rspec", "~> 3.0"
end