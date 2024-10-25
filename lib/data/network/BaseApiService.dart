abstract class BaseaApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);

  getGetApiWithHeaderResponse(String mainDescription, header) {}
}
