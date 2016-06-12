# hotels-client
It is hosted on heroku (https://mighty-beyond-12582.herokuapp.com/).

To run project locally:
* download project
* run 'bundle'
* run 'rails db:create db:migrate'
* run 'bundle exec rspec'

I've created 2 projects
1. Rails 5 API project. It has implemented CRUD functionality with validations, Rspec tests,
   different best practices (Service objects). It stores all data about hotels in Postgres.
   It is hosted on heroku.
   Please visit:
    * GET accomodation_types: https://evening-cliffs-68697.herokuapp.com/api/accomodation_types
    * GET suggestions: https://evening-cliffs-68697.herokuapp.com/api/suggestions?query=26
    * GET all hotels: https://evening-cliffs-68697.herokuapp.com/api/hotels
    * GET new hotel: https://evening-cliffs-68697.herokuapp.com/api/hotels/new
    * GET show hotel: https://evening-cliffs-68697.herokuapp.com/api/hotels/6
    * POST create hotel: https://evening-cliffs-68697.herokuapp.com/api/hotels
    * PUT create hotel: https://evening-cliffs-68697.herokuapp.com/api/hotels/6
    * DELETE delete hotel: https://evening-cliffs-68697.herokuapp.com/api/hotels/6

   Please review its code in my github repo: https://github.com/gioch/hotels-api
   It's readme has documentation about running project locally

2. Rails 5 client project, which connects to API project above
It has implemented CRUD functionality, rspec testings (Not finished, because i've used rspec testings in API project, and here they are almost the same),
Ajax autocomplete, which returns suggestions for hotel name/address,
Used some design pattersn such as Service Objects

It is also hosted on Heroku, as separated project.
* Please visit it here: https://mighty-beyond-12582.herokuapp.com/
