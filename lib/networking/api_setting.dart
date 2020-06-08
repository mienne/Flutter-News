enum APISetting { news, everything }

class APISettingHelper {
  static const _scheme = 'https';
  static const _host = 'newsapi.org/v2';
  // TODO: - https://newsapi.org/ API Key 발급
  static const _apiKey = '';

  static String getUrl(APISetting apiSetting, {String query = ''}) {
    switch (apiSetting) {
      case APISetting.news:
        return '$_scheme://$_host/top-headlines?country=us&apiKey=$_apiKey';
      case APISetting.everything:
        return '$_scheme://$_host/everything?q=$query&apiKey=$_apiKey';
      default:
        return '';
    }
  }
}
