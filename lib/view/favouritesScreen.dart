import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pexel/models/favourite_post.dart';
import 'package:pexel/view/common/VideoPostWidget.dart';
import 'package:pexel/view/common/imagePostWidget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen();

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }
}

ListView _buildListView() {
  final favouritesBox = Hive.box('favourites');
  print(favouritesBox.length);

  return ListView.builder(
      itemCount: favouritesBox.length,
      itemBuilder: (BuildContext context, int index) {
        final favouritePost = favouritesBox.getAt(index) as FavouritePost;
        print(favouritePost);

        if (favouritePost.postType == "image") {
          return ImagePost(
            postId: favouritePost.postId,
            authorName: favouritePost.postAuthorName,
            thumbnailImageLink: favouritePost.postThumbnailImageLink,
            postImageLink: favouritePost.postMediaLink,
          );
        } else
          return VideoPost(
            postId: favouritePost.postId,
            authorName: favouritePost.postAuthorName,
            videoThumbnail: favouritePost.postThumbnailImageLink,
            videoUrl: favouritePost.postMediaLink,
          );
      });
}
