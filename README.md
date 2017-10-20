# README

* Ruby version ruby 2.4.0
* Rails version ruby Rails 5.0.6

# Setups to setup project on development env

* Clone the project
* bundle install
* update database.yml file
* rake db:create, rake db:migrate
* rails s


# Details

* Only Manager/User can create projects
* Only QA and manager can add bugs
* Manager can see all projects
* Only developer can see *My bugs (assign bugs)*
* Only QA can see *Created bugs* and manager can see all bugs
