const String appName = 'Breezly';
const int timeout = 5; //seconds
// Storing API key in local is not advisable
// but for the sake of this app, I just use this one
const String apiKey = 'b23c363889dae82a0495c0b6f346d519';

// Ref: api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}'; -> City Name
// Ref2: api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key} -> Lat Lon
const String mainUrl = 'api.openweathermap.org';
const String weatherUrl = 'data/2.5/weather';
const String forecast = 'data/2.5/forecast';
// https://api.openweathermap.org/data/2.5/weather%3F?

const String citySharedPrefs = 'cities';