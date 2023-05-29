// You have to put your own key here
// Go to https://api.nasa.gov/ to get your
//
// DEMO_KEY works for testing purposes only and has access limitations
//
// When you got your key change the get api Key from DEMO_KEY to your own key

class Environment {
  static String urlBase = "https://api.nasa.gov/planetary/apod?api_key=$apidKey&thumbs=true";
  static String get apidKey => "DEMO_KEY";
}
