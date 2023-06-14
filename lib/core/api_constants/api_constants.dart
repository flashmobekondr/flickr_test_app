final class ApiConstants {
  static const String authorityFlickrUrl = 'www.flickr.com';
  static const String restPath = 'services/rest/';
  static const String baseEndpointUrl = 'https://www.flickr.com/services/rest/';
  static const String photoImageUrl = 'https://live.staticflickr.com';
  static const String apiKey = 'c489e580513435a1fada09a6ee28579b';
  static const String photoSearchMethod = 'flickr.photos.search';
  static const String format = 'json';
  static const String perPage = '40';
}
final class SizeSuffix {
  static const String thumbnail_75 = 's';
  static const String thumbnail_150 = 'q';
  static const String thumbnail_100 = 't';
  static const String small_240 = 'm';
  static const String small_320 = 'n';
  static const String small_400 = 'w';
  static const String medium_640 = 'z';
  static const String medium_800 = 'c';
  static const String large_1024 = 'b';
}

Map<String, String> sizeSuffix = {
        'thumbnail_75':'s',
        'thumbnail_150':'q',
        'thumbnail_100':'t',
        'small_240':'m',
        'small_320':'n',
        'small_400':'w',
        'medium_640':'z',
        'medium_800':'c',
        'large_1024':'b',
};
// The various sizes offered on Flickr have the following letter suffixes:
// s	thumbnail	75	cropped square
// q	thumbnail	150	cropped square
// t	thumbnail	100
// m	small	240
// n	small	320
// w	small	400
// (none)	medium	500
// z	medium	640
// c	medium	800
// b	large	1024

// Unique URL format for 500px size
// https://live.staticflickr.com/{server-id}/{id}_{secret}.jpg

// REST Request for photo.search method with text and page parameters
//https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=c489e580513435a1fada09a6ee28579b&text=waterfall&per_page=20&format=json&nojsoncallback=1