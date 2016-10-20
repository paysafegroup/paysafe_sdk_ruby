# Paysafe Ruby SDK

___


## Installation

### Manual

To build and install the gem manually run the following commands from the root project folder: 

    gem build paysafe.gemspec
    gem install paysafe


### Windows
On Windows, you will be required set an environment variable named "SSL_CERT_FILE" that points to a valid CA certificate on your system in order to perform the https operations.

## Usage

### Running The Sample App

Update the following file with your account number, credentials and currency details:

> /sample\_rails\_app/config/environments/development.rb
   

Run the following commands: 
    
    bundle install
    rails server

Open your web browser and navigate to:

[http://localhost:3000](http://localhost:3000)