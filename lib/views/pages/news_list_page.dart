import 'package:flutter/material.dart';
import 'package:news_app/view_models/loading_status.dart';
import 'package:news_app/views/widgets/news_list.dart';
import 'package:news_app/views/pages/news_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:news_app/view_models/news_article_list_view_model.dart';
import 'package:news_app/view_models/news_article_view_model.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final _controller = TextEditingController();
  // NewsArticleListViewModel 생성자에서 populateTopHeadline() 함수를 호출하지 않고 아래에서 한다면 결과를 화면에서 나타나지 않음
  // NewsArticleListViewModel _viewModel = NewsArticleListViewModel();

  // NewsListPage() {
  //   _viewModel.populateTopHeadlines();
  // }

  // 2. StatefulWidget 이용하는 방법
  @override
  void initState() {
    super.initState();

    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .populateTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewsArticleListViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Top News')),
        body: Column(children: <Widget>[
          TextField(
              controller: _controller,
              onSubmitted: (value) => _searchButtonDidTap(value, viewModel),
              decoration: InputDecoration(
                  labelText: 'Enter keyword😅',
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: _clearButtonDidTap,
                  ))),
          _buildList(context, viewModel)
        ]));
  }

  Widget _buildList(BuildContext context, NewsArticleListViewModel viewModel) {
    switch (viewModel.status) {
      case LoadingStatus.loading:
        return Align(child: CircularProgressIndicator());
      case LoadingStatus.empty:
        return Align(child: Text('No results!'));
      case LoadingStatus.completed:
        return Expanded(
            child: NewsList(
                articles: viewModel.articles,
                onSelect: (article) => _showDetailPage(context, article)));
    }
  }

  void _clearButtonDidTap() => _controller.clear();

  void _searchButtonDidTap(String value, NewsArticleListViewModel viewModel) =>
      value.isNotEmpty
          ? viewModel.findHeadlines(keyword: value)
          : print('Keyword is empty.');

  void _showDetailPage(BuildContext context, NewsArticleViewModel article) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsDetailPage(article: article)));
}
