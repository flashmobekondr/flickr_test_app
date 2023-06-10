final class ApiConstants {
  static const String baseEndpointUrl = "https://www.flickr.com/services/rest/";
  static const String photoImageUrl = "https://live.staticflickr.com";
  static const String rawApiKey = "c489e580513435a1fada09a6ee28579b";
  static const String apiKey = "&pi_key=c489e580513435a1fada09a6ee28579b";
  static const String photoSearchMethod = "?method=flickr.photos.search";
  static const String text = "&text=";
  static const String perPage = "&per_page=";
  static const String format = "&format=json&nojsoncallback=1";
  //static  String searchPageBasedFinalEndpointUrl;

}

// Unique URL format for 500px size
// https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg

// REST Request for photo.search method with text and page parameters
//https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c489e580513435a1fada09a6ee28579b&text=waterfall&per_page=20&format=json&nojsoncallback=1