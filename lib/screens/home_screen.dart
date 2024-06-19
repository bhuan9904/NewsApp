import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:way2_news_app_design/post_item.dart';
import 'package:way2_news_app_design/utils/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<HomeScreen> {
  List<dynamic> _data = [];
  bool _isLoading = false;
  String _error = '';
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final data = await fetchData();
      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _navigateToPage(int pageIndex) {
    if (pageIndex >= 0 && pageIndex < _data.length) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _error.isNotEmpty
                ? Center(
                    child: Text(_error),
                  )
                : _data.isEmpty
                    ? const Center(
                        child: Text('No data found'),
                      )
                    : Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final item = _data[index];
                              return PostItem(
                                postImage: item['PostImage'] ?? '',
                                postTitle: item['PostTitle'] ?? 'N/A',
                                app: item['App'] ?? 'N/A',
                                postingDate: item['PostingDate'] ?? 'N/A',
                                categoryName: item['CategoryName'] ?? 'N/A',
                                url: item['Url'] ?? '',
                              );
                            },
                          ),
                          Positioned(
                            left: 16.0,
                            bottom: 16.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                          Positioned(
                            right: 16.0,
                            bottom: 16.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ),
                          Positioned(
                            bottom: 16.0,
                            left: MediaQuery.of(context).size.width / 2.5,
                            child: ElevatedButton(
                              onPressed: () {
                                final pageIndex = _pageController.page!.round();
                                final post = _data[pageIndex];
                                final postTitle = post['PostTitle'];
                                final postUrl = post['Url'];
                                if (postUrl != null && postUrl.isNotEmpty) {
                                  Share.share('Check out this post: $postTitle\n$postUrl');
                                } else {
                                  // Handle case where URL is missing or empty
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(16.0),
                              ),
                              child: const Icon(Icons.share),
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}
