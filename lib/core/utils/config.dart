class Config {
  final String _apiDomain = 'instacrm.rapidcollaborate.com';
  // final String _apiDomain = 'rapidcollaborate.com';
  final String _basePath = 'api';
  Uri apiUri(String path, {Map<String, dynamic>? queryParameters}) {
    final Uri url = Uri.https(
      _apiDomain,
      '$_basePath$path',
      queryParameters,
    );
    return url;
  }
}
