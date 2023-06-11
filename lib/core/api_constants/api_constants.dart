final class ApiConstants {
  static const String authorityFlickrUrl = 'www.flickr.com';
  static const String restPath = 'services/rest/';
  static const String baseEndpointUrl = 'https://www.flickr.com/services/rest/';
  static const String photoImageUrl = 'https://live.staticflickr.com';
  static const String apiKey = 'c489e580513435a1fada09a6ee28579b';
  static const String photoSearchMethod = 'flickr.photos.search';
  static const String format = 'json';
  static const String perPage = '40';
  //static  String searchPageBasedFinalEndpointUrl;

}

// Unique URL format for 500px size
// https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg

// REST Request for photo.search method with text and page parameters
//https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c489e580513435a1fada09a6ee28579b&text=waterfall&per_page=20&format=json&nojsoncallback=1