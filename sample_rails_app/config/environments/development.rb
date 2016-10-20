Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  config.optimal_account_number = "1000032987"
  config.optimal_api_key = "devcentre4651"
  config.optimal_api_secret = "B-qa2-0-54b5374e-302d02147911306b5c6db4ad74e083803733163195c75ef902150095b4a21a5ea7f4c19b7b37aed1944490b59e785e"

  config.optimal_account_number_1 = "89983472"
  config.optimal_api_key_1 = "devcentre4628"
  config.optimal_api_secret_1 = "B-qa2-0-548ef25d-302b0213119f70d83213f828bc442dfd0af3280a7b48b1021400972746f9abe438554699c8fa3617063ca4c69a"

  config.optimal_ach_account_number = "1001057430"
  config.optimal_eft_account_number = "1001057670"
  config.optimal_sepa_account_number = "1001057620"
  config.optimal_bacs_account_number = "1001057660"

  # The currencyCode should match the currency of your Optimal account. 
  # The currencyBaseUnitsMultipler should in turn match the currencyCode.
  # Since the API accepts only integer values, the currencyBaseUnitMultiplier is used convert the decimal amount into the accepted base units integer value.
  config.currency_code = "USD" # for example: CAD
  config.currency_base_units = "100" # for example: 100

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
