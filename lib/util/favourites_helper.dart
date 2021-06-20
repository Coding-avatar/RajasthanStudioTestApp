import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pexel/models/favourite_post.dart';

void addToFavourites(
    {@required String postId, @required FavouritePost favouritePost}) {
  final favouritesBox = Hive.box('favourites');
  favouritesBox.put(postId, favouritePost);
}

void removeFromFavourites({@required String postId}) {
  final favouritesBox = Hive.box('favourites');
  favouritesBox.delete(postId);
}
