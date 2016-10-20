<<-DOC
 * Copyright (c) 2016 Paysafe
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 DOC


require_relative "paysafe/card_payment_service"
require "paysafe/customer_vault_service"
require "paysafe/environment"
require "paysafe/hosted_payment_service"
require "paysafe/json_object"
require "paysafe/paysafe_api_client"
require "paysafe/pagerator"
require "paysafe/request"
require "paysafe/direct_debit_service"
require "paysafe/three_d_secure_service"

require "paysafe/card_payments/authentication"
require "paysafe/card_payments/authorization"
require "paysafe/card_payments/authorization_reversal"
require "paysafe/card_payments/billing_details"
require "paysafe/card_payments/profile"
require "paysafe/card_payments/refund"
require "paysafe/card_payments/settlement"
require "paysafe/card_payments/shipping_details"
require "paysafe/card_payments/verification"

require "paysafe/customer_vault/address"
require "paysafe/customer_vault/card"
require "paysafe/customer_vault/profile"
require "paysafe/customer_vault/bank_account"
require "paysafe/customer_vault/ach_bank_account"
require "paysafe/customer_vault/eft_bank_account"
require "paysafe/customer_vault/sepa_bank_account"
require "paysafe/customer_vault/bacs_bank_account"
require "paysafe/customer_vault/mandate"

require "paysafe/hosted_payment/billing_details"
require "paysafe/hosted_payment/card"
require "paysafe/hosted_payment/order"
require "paysafe/hosted_payment/refund"
require "paysafe/hosted_payment/settlement"
require "paysafe/hosted_payment/shipping_details"
require "paysafe/hosted_payment/transaction"

require "paysafe/errors/paysafe"
require "paysafe/errors/api"
require "paysafe/errors/entity_not_found"
require "paysafe/errors/invalid_credentials"
require "paysafe/errors/invalid_request"
require "paysafe/errors/paysafe"
require "paysafe/errors/permission"
require "paysafe/errors/request_conflict"
require "paysafe/errors/request_declined"

require "paysafe/direct_debit/ach"
require "paysafe/direct_debit/profile"
require "paysafe/direct_debit/billing_details"
require "paysafe/direct_debit/purchase"
require "paysafe/direct_debit/standalone_credits"
require "paysafe/direct_debit/shipping_details"
require "paysafe/direct_debit/eft"
require "paysafe/direct_debit/bacs"

require "paysafe/three_d_secure/authentications"
require "paysafe/three_d_secure/card"
require "paysafe/three_d_secure/card_expiry"
require "paysafe/three_d_secure/enrollment_checks"
require "paysafe/three_d_secure/error"

module paysafe
end
