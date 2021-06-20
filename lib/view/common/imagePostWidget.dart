import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pexel/models/favourite_post.dart';
import 'package:pexel/util/favourites_helper.dart';
import 'package:pexel/view/fullScreenImage.dart';

class ImagePost extends StatefulWidget {
  const ImagePost(
      {Key key,
      this.authorName,
      this.thumbnailImageLink,
      this.postImageLink,
      this.postId})
      : super(key: key);
  final String authorName;
  final String thumbnailImageLink;
  final String postImageLink;
  final String postId;

  @override
  _ImagePostState createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  bool _isLiked = false;
  bool _isFavoriteIconVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ///Photographer Image and Name
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.thumbnailImageLink),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.authorName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          ///Photo
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ImageViewer(
                  imageLink: widget.postImageLink,
                ),
              ),
            ),
            onDoubleTap: _doubleTapped,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.postImageLink),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  /// Size of container by 2 minus half size of icon
                  top: MediaQuery.of(context).size.height * 0.35 - 40,
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
                      postType: 'image',
                      postAuthorName: widget.authorName,
                      postThumbnailImageLink: widget.thumbnailImageLink,
                      postMediaLink: widget.postImageLink,
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
          postType: 'image',
          postAuthorName: widget.authorName,
          postThumbnailImageLink: widget.thumbnailImageLink,
          postMediaLink: widget.postImageLink,
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
