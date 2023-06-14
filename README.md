# Sweater Weather

Sweater Weather is a backend API that provides endpoints for road trip data, user creation, login features, and weather data for any location.

## Learning Goals

The primary learning goals of this project are:

- Creating Backend API
- Proper error responses
- Consuming data from separate API'S to make an API of my own

## Cloning and Setup

To clone and set up the application locally, follow these steps:

1. Clone the repository:
```
   git clone git@github.com:Bluedevil667/sweater_weather.git
```
2. Navigate to the project directory:
```
   cd sweater_weather
```
3. Install dependencies:
```
   bundle install
```
4. Set up the database:
```
   rails db:{create,migrate}
```
5. Obtain API Keys:
```
WEATHER_API_KEY: https://www.weatherapi.com/

MAPQUEST_API_KEY: https://developer.mapquest.com/documentation/geocoding-api/

GOOGLE_API_KEY: https://developers.google.com/maps
```
6. Install figaro:
```
bundle exec figaro install
```
7. Configure API Keys:
```
*Navigate to config/application.yml*

WEATHER_API_KEY: <your api key>
MAPQUEST_API_KEY: <your api key>
GOOGLE_API_KEY: <your api key>
```
8. Start the application:
```
rails s
```
# Endpoint Use
## Examples
Retrieve Weather for a city:
```
GET /api/v0/forecast?location=cincinatti,oh
```
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2023-04-07 16:30",
        "temperature": 55.0,
        etc
      },
      "daily_weather": [
        {
          "date": "2023-04-07",
          "sunrise": "07:13 AM",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00",
          "temperature": 54.5,
          etc
        },
        {...} etc
      ]
    }
  }
}
```
## Create New User Request
```
POST /api/v0/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
## Create New User Response
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
## Login Request
```
POST /api/v0/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```
## Login Response
```
status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
    }
  }
}
```
## Road Trip Request
```
POST /api/v0/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Cincinatti,OH",
  "destination": "Chicago,IL",
  "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
}
```
## Road Trip Response
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "Cincinatti, OH",
            "end_city": "Chicago, IL",
            "travel_time": "04:40:45",
            "weather_at_eta": {
                "datetime": "2023-04-07 23:00",
                "temperature": 44.2,
                "condition": "Cloudy with a chance of meatballs"
            }
        }
    }
}
```
# Authors
- Logan Wilson [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ]( https://github.com/Bluedevil667) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/logan-wilson-28422ba0/)
