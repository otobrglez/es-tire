require "bundler/setup"

require "rspec"
require "tire"


Tire.configure do
  logger 'log/tire.log', level: 'debug'
end


RSpec.configure do |config|
  config.run_all_when_everything_filtered = true

  config.before :all do
  end

  config.before :each do
  end

  config.after :each do
  end

end
