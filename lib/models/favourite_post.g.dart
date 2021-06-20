// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritePostAdapter extends TypeAdapter<FavouritePost> {
  @override
  final int typeId = 1;

  @override
  FavouritePost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritePost(
      postId: fields[4] as String,
      postType: fields[0] as String,
      postAuthorName: fields[1] as String,
      postThumbnailImageLink: fields[2] as String,
      postMediaLink: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritePost obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.postType)
      ..writeByte(1)
      ..write(obj.postAuthorName)
      ..writeByte(2)
      ..write(obj.postThumbnailImageLink)
      ..writeByte(3)
      ..write(obj.postMediaLink)
      ..writeByte(4)
      ..write(obj.postId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritePostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
