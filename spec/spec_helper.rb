# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
require 'shoulda/matchers'

SimpleCov.start do
  add_filter "/spec/"
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Request::JsonHelpers, :type => :controller
  config.include Request::HeadersHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :controller
  config.before(:each, type: :controller) do
    include_default_accept_headers
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
    with.library :active_record
    with.library :active_model
  end
end
