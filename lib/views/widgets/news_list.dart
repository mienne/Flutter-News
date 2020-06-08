import 'package:flutter/material.dart';
import 'package:news_app/view_models/news_article_view_model.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticleViewModel> _articles;
  final Function(NewsArticleViewModel article) _onSelect;

  NewsList({articles, onSelect})
      : this._articles = articles,
        this._onSelect = onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
          return ListTile(
              onTap: () => this._onSelect(article),
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: article.thumbnail)),
              ),
              title: Text(article.title));
        });
  }
}
