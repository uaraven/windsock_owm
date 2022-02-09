# Windsock OWM

![](img/windsock.png) 

Connect IQ data field which displays wind direction relative to the direction you're moving. Designed for the Edge head units.

This is an companion data field for [Windsock](https://github.com/uaraven/windsock) and it supports more devices and support more frequent wind updates, but 
requires more complex set up.

Windsock OWM requires Connect IQ 3.1 and higher and works* on following devices:
 
  - Edge 130
  - Edge 130+
  - Edge 520+
  - Edge 530
  - Edge 820
  - Edge 830
  - Edge 1030
  - Edge 1030+
  - Edge Explore

Unfortunately I was not able to make Edge 520 and Edge 1000 work reliably, so these devices are not officially supported.

Data field displays direction the wind is coming at you and wind speed (units depend on your device settings).

![](img/data_field.png)

Arrow will change the color from green to red depending on the wind strength and direction, i.e. tailwind is always good(green) and light headwind is not a big deal either (green), but stronger headwind will be shown in orange or red.

The windsock data field uses OpenWeatherMap as weather provider, you will need to register an API key and configure Windsock OWM to use it.

## Configuration

You will need your own API key to use OpenWeather service. Obtaining one is free. Go to [OpenWeather](https://home.openweathermap.org/api_keys) website and create an account,
then navigate to "API keys" tab.

In the "Create key" input type the name of the key (Windsock OWM, or anything else you like) and click on "Generate" button.
![](img/owm_create_key.png)

Copy generated key and insert it into Windsock OWM configuration in Garmin Connect Mobile.
![](img/owm_generated_key.png)

_Don't use the key from the image above, it is invalid_.

You may want to double check that you're on Free plan in the "Billing plans" tab.

![](img/owm_billing_plans.png)

## Note about correctness

At the beginning there might be no wind data available or the wind data could be retrieved for the incorrect location (the last location where device was on). Windsock OWM continiusly updates weather data and 5 minutes into your ride you should get correct wind information for your location.

Still wind strength and direction shown by Windsock OWM may not reflect what you experience in the real life. Treat it as an approximate suggestion, not as the definite truth.

## License

Windsock OWM is an open source project and distributed under GPLv3 license. You can find the license in the [license.md](license.md) file

-----
\* should work, at least
