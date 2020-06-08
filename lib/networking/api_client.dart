import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/new_article.dart';
import 'package:news_app/networking/api_setting.dart';

class ApiClient {
  Future<List<NewsArticle>> fetchTopHeadline() async =>
      _fetch(await http.get(APISettingHelper.getUrl(APISetting.news)));

  Future<List<NewsArticle>> fetchHeadlineByKeyword(String keyword) async =>
      _fetch(await http
          .get(APISettingHelper.getUrl(APISetting.everything, query: keyword)));

  Future<List<NewsArticle>> _fetch(http.Response response) async {
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable articles = body['articles'];
      return articles.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      return List();
    }
  }
}
