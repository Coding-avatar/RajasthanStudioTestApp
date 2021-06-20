import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pexel/models/favourite_post.dart';
import 'package:pexel/util/favourites_helper.dart';
import 'package:pexel/view/videoPlayerScreen.dart';

class VideoPost extends StatefulWidget {
  final String authorName;
  final String videoThumbnail;
  final String videoUrl;
  final String postId;
  const VideoPost(
      {Key key,
      this.authorName,
      this.videoUrl,
      this.videoThumbnail,
      this.postId})
      : super(key: key);

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  bool _isLiked = false;
  bool _isFavoriteIconVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.authorName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          ///video thumbnail
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(
                  videoUrl: widget.videoUrl,
                ),
              ),
            ),
            onDoubleTap: _doubleTapped,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.videoThumbnail),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  /// Size of container by 2 minus half size of icon
                  top: MediaQuery.of(context).size.width / 2 - 40,
                  left: MediaQuery.of(context).size.width / 2 - 40,
                  child: AnimatedOpacity(
                    opacity: _isFavoriteIconVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.pink : Colors.white,
                      size: 80.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isLiked = !_isLiked;
                  if (_isLiked == true) {
                    final newFavouritePost = FavouritePost(
                      postId: widget.postId,
                      postType: 'video',
                      postAuthorName: widget.authorName,
                      postThumbnailImageLink: widget.videoThumbnail,
                      postMediaLink: widget.videoUrl,
                    );
                    addToFavourites(
                        postId: widget.postId, favouritePost: newFavouritePost);
                  }

                  if (_isLiked == false) {
                    removeFromFavourites(postId: widget.postId);
                  }
                });
              },
              iconSize: 35,
              icon: _isLiked
                  ? Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.black54,
                    ),
            ),
          )
        ],
      ),
    );
  }

  _doubleTapped() {
    setState(() {
      _isFavoriteIconVisible = true;
      _isLiked = !_isLiked;
      if (_isLiked == true) {
        final newFavouritePost = FavouritePost(
          postId: widget.postId,
          postType: 'video',
          postAuthorName: widget.authorName,
          postThumbnailImageLink: widget.videoThumbnail,
          postMediaLink: widget.videoUrl,
        );
        addToFavourites(postId: widget.postId, favouritePost: newFavouritePost);
      }
      if (_isLiked == false) {
        removeFromFavourites(postId: widget.postId);
      }
    });
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        _isFavoriteIconVisible = false;
      });
    });
  }
}
