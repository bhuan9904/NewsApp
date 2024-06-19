import 'package:flutter/material.dart';

import 'post_content.dart';

class PostItem extends StatefulWidget {
  final String postImage;
  final String postTitle;
  final String app;
  final String postingDate;
  final String categoryName;
  final String url;

  const PostItem({
    Key? key,
    required this.postImage,
    required this.postTitle,
    required this.app,
    required this.postingDate,
    required this.categoryName,
    required this.url,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double value = _animation.value;
          final double angle = value * 3.141592;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: value > 0.5 ? Alignment.centerLeft : Alignment.centerRight,
            child: child,
          );
        },
        child: PostContent(
          postImage: widget.postImage,
          postTitle: widget.postTitle,
          app: widget.app,
          postingDate: widget.postingDate,
          categoryName: widget.categoryName,
          url: widget.url,
        ),
      ),
    );
  }
}
