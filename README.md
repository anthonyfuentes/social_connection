
# social_connection

Fully functional social networking site. 

![screenshot of the social connection home page](https://github.com/anthonyfuentes/social_connection/blob/master/social-connection.png)

## Technical Higlights
1. Back-end
  * Delayed::Job email handling
  * Feature testing with [Capybara](https://github.com/teamcapybara/capybara)
  * Unit testing with [rspec-rails](https://github.com/rspec/rspec-rails)
  * Fixture replacement with [factory_girl](https://github.com/thoughtbot/factory_girl)
  * Image uploading to AWS S3 using [Paperclip](https://github.com/thoughtbot/paperclip)
  * PostgreSQL database schema including polymorphic, and self-referencing associations
2. Front-end
  * Bootstrap
  * [simple forms](https://github.com/plataformatec/simple_form)

## Running social_connection locally
1. Fork this repo
2. Clone the fork to your machine
3. Bundle install all gems `$ bundle install`
4. Setup database
  1. `$ rails db:create`
  2. `$ rails db:migrate`
  3. `$ rails db:seed`
5. Start a Rails server `$ rails s`
6. Uploading photos requires an Amazon AWS bucket and credentials
