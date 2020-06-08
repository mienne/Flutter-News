import 'package:flutter/material.dart';
import 'package:news_app/models/new_article.dart';

class NewsArticleViewModel {
  NewsArticle _article;

  NewsArticleViewModel({NewsArticle article}) : _article = article;

  String get title => _article.title;
  String get desciption => _article.description;
  String get url => _article.url;
  ImageProvider get thumbnail => _article.urlToImage == null
      ? Image.asset('images/news_placeholder.png').image
      : NetworkImage(_article.urlToImage);
}
