Rails.application.routes.draw do
  root 'home#index'
  # match "hosted_payment_simple", to: "hosted_payment#simple", via: [:get, :post]
  # match "hosted_payment_silent", to: "hosted_payment#silent", via: [:get, :post]
  # match "hosted_payment_silent_card", to: "hosted_payment#silent_card", via: [:get, :post]

  match "card_payment_simple", to: "card_payment#simple", via: [:get, :post]
  match "card_payment_customer_vault", to: "card_payment#customer_vault", via: [:get, :post]

  match "customer_vault", to: "customer_vault#index", via: [:get, :post]
  match "create_ach_account", to: "customer_vault#create_ach_account", via: [:get, :post]
  match "create_eft_account", to: "customer_vault#create_eft_account", via: [:get, :post]
  match "create_bacs_account", to: "customer_vault#create_bacs_account", via: [:get, :post]
  match "create_sepa_account", to: "customer_vault#create_sepa_account", via: [:get, :post]
  match "create_sepa_mandate", to: "customer_vault#create_sepa_mandate", via: [:get, :post]
  match "create_bacs_mandate", to: "customer_vault#create_bacs_mandate", via: [:get, :post]

  match "three_d_secure_index", to: "three_d_secure#index", via: [:get, :post]
  match "submit_enrollment", to: "three_d_secure#submit_enrollment", via: [:get, :post]
  match "submit_authentication", to: "three_d_secure#submit_authentication", via: [:get, :post]

  match "direct_debit", to: "direct_debit#index", via: [:get, :post]
  match "direct_debit_purchase_ach", to: "direct_debit#purchase_ach", via: [:get, :post]
  match "direct_debit_purchase_ach_token", to: "direct_debit#purchase_ach_payment_token", via: [:get, :post]
  match "direct_debit_purchase_eft", to: "direct_debit#purchase_eft", via: [:get, :post]
  match "direct_debit_purchase_eft_token", to: "direct_debit#purchase_eft_payment_token", via: [:get, :post]
  match "direct_debit_purchase_bacs", to: "direct_debit#purchase_bacs", via: [:get, :post]
  match "direct_debit_purchase_bacs_token", to: "direct_debit#purchase_bacs_payment_token", via: [:get, :post]
  match "direct_debit_purchase_sepa", to: "direct_debit#purchase_sepa", via: [:get, :post]
  match "direct_debit_purchase_sepa_token", to: "direct_debit#purchase_sepa_payment_token", via: [:get, :post]

  match "direct_debit_standalone_credits_ach", to: "direct_debit#standalone_credits_ach", via: [:get, :post]
  match "direct_debit_standalone_credits_ach_token", to: "direct_debit#standalone_credits_ach_payment_token", via: [:get, :post]
  match "direct_debit_standalone_credits_eft", to: "direct_debit#standalone_credits_eft", via: [:get, :post]
  match "direct_debit_standalone_credits_eft_token", to: "direct_debit#standalone_credits_eft_payment_token", via: [:get, :post]
  match "direct_debit_standalone_credits_bacs_token", to: "direct_debit#standalone_credits_bacs_payment_token", via: [:get, :post]
end
