ENV['RACK_ENV'] = 'test'

require 'locality'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.color = true
  config.fail_fast = true

  config.before do
    Locality::Postnummerservice.reset!
  end
end

