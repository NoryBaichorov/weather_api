# Weather API

This project is an API created using Ruby on Rails. API documentation is available in Swagger JSON format. By default, it shows the time and temperature in London.
***

## Setup

Clone the repository:

``` bash
git clone https://github.com/NoryBaichorov/weather_api.git
cd weather_api
```

Then run:

```
bundle install
```

And then:

```
bin/rails server
```

## Description

You can get:
* `http://localhost:3000/weather/current` - shows current weather.
* `http://localhost:3000/weather/historical` - shows the weather for the last 24 hours.
* `http://localhost:3000/weather/historical/max` - shows the hottest temperature and time in the last 24 hours.
* `http://localhost:3000/weather/historical/min` - shows the coldest temperature and time in the last 24 hours.
* `http://localhost:3000/weather/historical/avg`- shows the average temperature and time in the last 24 hours.
* `http://localhost:3000/weather/health` - an auxiliary request. Shows the response from the server - OK. This request is needed to check the server activity.
* `http://localhost:3000/weather/by_time?time=1621823790` - shows the temperature according to the set time. If one is not found, it returns the 404 status. Instead of 1621823790, you can use your own timestamp.
* `http://localhost:3000/swagger_doc` - shows the documentation.

## Optionally
You can run:

```
bundle exec rspec
```

to run integration tests on all endpoints.

## Support
If you have any questions or problems, please create an issue in the repository or contact us by email <nory.baichorov@gmail.com>

## License

This project is licensed under the [MIT License](https://gem-chat.hf.space/LICENSE)
