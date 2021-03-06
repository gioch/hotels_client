ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort('Rails environment is running in production!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'

dir_files = File.join(File.dirname(__FILE__), 'support', '**', '*.rb')
dir_file_paths = File.expand_path(dir_files)
Dir[dir_file_paths].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Rails::Controller::Testing::TestProcess
  config.include Rails::Controller::Testing::TemplateAssertions
  config.include Rails::Controller::Testing::Integration

  config.infer_spec_type_from_file_location!
  config.fixture_path = '#{::Rails.root}/spec/fixtures'
  config.use_transactional_fixtures = true
end
