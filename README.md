# README

# Versions
* Ruby version: ruby 2.6.8p205
* Rails Version: Rails 6.1.4.4

# Configuration
* Configuration: run below commands to setup project on local
* $ git clone https://github.com/devmozmbutt/zombie-apocalypse-survival.git
* $ bundle install
* $ rails db:create
* $ rails db:migrate
* $ rails db:seed

# Login
* Data seed will create dummy users and admin
* For admin login:
* email: admin@devsinc.com
* password: 000000
* For survivor login:
* email: moazzam.ali@devsinc.com
* password: 000000

# Database
* Database: postgresql

# Gems
* devise    (For user authentication)
* pg        (For postgresql database)
* ransack   (For searching users)
* cancancan (For manage abilities of user roles)

# Features/Modules
* Add survivors to the database
* Update survivor location
* Profile Picture
* Flag survivor as infected
* Survivors cannot Add/Remove items from inventory
* Search Survivors
* Trade items
* Trade History
* Reports
* Roles (Admin, Survivor)