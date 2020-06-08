import 'package:flutter/material.dart';
import 'package:news_app/models/new_article.dart';
import 'package:news_app/networking/api_client.dart';
import 'package:news_app/view_models/news_article_view_model.dart';
import 'package:news_app/view_models/loading_status.dart';

class NewsArticleListViewModel extends ChangeNotifier {
  final _client = ApiClient();
  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();
  var _status = LoadingStatus.loading;

  // 1. ViewModel 생성자에서 populateTopHeadlines 호출하는 방법
  // NewsArticleListViewModel() {
  //   _populateTopHeadlines();
  // }

  LoadingStatus get status => this._status;

  void _notify({LoadingStatus status}) {
    this._status = status;
    notifyListeners();
  }

  void findHeadlines({String keyword}) async =>
      _updateHeadlines(await _client.fetchHeadlineByKeyword(keyword));

  void populateTopHeadlines() async =>
      _updateHeadlines(await _client.fetchTopHeadline());

  void _updateHeadlines(List<NewsArticle> _articles) {
    _notify(status: LoadingStatus.loading);
    this.articles = _articles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();
    this.articles.isEmpty
        ? _notify(status: LoadingStatus.empty)
        : _notify(status: LoadingStatus.completed);
  }
}
