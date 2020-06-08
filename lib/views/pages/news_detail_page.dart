import 'package:flutter/material.dart';
import 'package:news_app/view_models/news_article_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class NewsDetailPage extends StatefulWidget {
  final NewsArticleViewModel _article;

  NewsDetailPage({article}) : this._article = article;

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(article: _article);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final NewsArticleViewModel _article;
  Completer<WebViewController> _controller = Completer<WebViewController>();

  _NewsDetailPageState({article}) : this._article = article;

  @override
  Widget build(BuildContext context) {
    print(this._article.url);
    return Scaffold(
        appBar: AppBar(title: Text(this._article.title)),
        body: WebView(
          initialUrl: this._article.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
