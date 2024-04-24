class ApiConstants {
  static String debugBaseUrl = 'http://10.0.2.2:8081';
  static String baseUrl = 'https://upark-capstone-web-server.web.app';
  // static String baseUrl = debugBaseUrl;
  static String lotsEndpoint = '/lots';
  static String reportsEndpoint = '/reports';
  static String postReportEndpoint = '/report';
  static String buildingsEndpoint = '/buildings';
  static String userEndpoint = '/users';
  static String distancesEndpoint = '/distances';
  static String distancesByLotEndpoint = '$distancesEndpoint/lot';
  static String distancesByBuildingEndpoint = '$distancesEndpoint/building';
  static String distancesByBothEndpoint = '$distancesEndpoint/both';
  static String setUserColorblindEndpoint = '/user/setColorblind';
}
