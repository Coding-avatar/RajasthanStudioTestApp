import 'package:hive/hive.dart';

part 'favourite_post.g.dart';

@HiveType(typeId: 1)
class FavouritePost {
  @HiveField(0)
  final String postType;

  @HiveField(1)
  final String postAuthorName;

  @HiveField(2)
  final String postThumbnailImageLink;

  @HiveField(3)
  final String postMediaLink;

  @HiveField(4)
  final String postId;

  FavouritePost({
    this.postId,
    this.postType,
    this.postAuthorName,
    this.postThumbnailImageLink,
    this.postMediaLink,
  });
}
