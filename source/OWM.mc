using Toybox.Position;
using Toybox.Communications;
using Toybox.Timer;
using Toybox.System;
using Toybox.Background;
using Toybox.Time;

using ATWUtils;

module OWM {

    (:background)
    const SHORT_DELAY = 5;  // delay when we wait for coordinates
    (:background)
    const LONG_DELAY = 10;  // delay after we got the weather for the first time
    (:background)
    public const windValid = "windValid";
    (:background)
    public const windSpeed = "windSpeed";
    (:background)
    public const windBearing = "windBearing";

    (:background)
    public var inBackground = false;

    public var windData;

    (:background)
    class OWMServiceDelegate extends System.ServiceDelegate {

        var apiKey = "";
        var lat;
        var lon;

        public function initialize() {
            ServiceDelegate.initialize();
            apiKey = Application.Properties.getValue("owm_api_key");
            lat = Application.Storage.getValue("bg_lat");
            lon = Application.Storage.getValue("bg_lon");
            inBackground = true;
            if (apiKey == null || apiKey == "") {
                System.println("No API Key configured");
            }
        }

        public function reSignUp(delay as Numeric) as Void {
            var now = Time.now();
            var next = now.add(new Time.Duration(delay*60));
            System.println("Scheduling next weather retrieval for " + ATWUtils.formatTime(next));
            Background.registerForTemporalEvent(next);
        }

        public function onTemporalEvent() as Void {
            if (lat == null || lon == null) {
                System.println("Location unknown, skipping OWM request");
                reSignUp(SHORT_DELAY);
                Background.exit({});
                return;
            }
            reSignUp(LONG_DELAY);
            if (apiKey != "" && apiKey != null) {
                updateWeather();
            } else {
                System.println("No API Key"); 
                Background.exit({});
            }
        }

        function onWeather(responseCode, data) {
            var result as Lang.Dictionary;
            if (responseCode != 200) {
                result = {windValid => false};
                System.println("OWM request failed: " + responseCode);
                System.println(data);
            } else {
                var wind = data["wind"];
                if (wind == null) {
                    System.print("Received OWM response, but no wind data: ");
                    System.println(data);
                    result = {windValid => false};
                } else {
                    System.print("Received OWM response: ");
                    System.println(wind);
                    result = {
                        windBearing => wind["deg"],
                        windSpeed => wind["speed"],
                        windValid => true};
                }
            }
            Background.exit(result);
        }

        // Query wind data from OpenWeatherMap
        function updateWeather() { 
            if (lat == null || lon == null) {
                Background.exit({});
            }
            System.println("Weather request at (" + lat + ", " + lon + ")");
            var url = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&apiKey=" + apiKey;

            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            };
            Communications.makeWebRequest(url, {}, options, self.method(:onWeather));
        }
    }

}