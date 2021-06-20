import 'dart:async';

import 'package:pexel/models/pexel_image_api_response.dart';
import 'package:pexel/networking/api_response.dart';
import 'package:pexel/repository/image_repository.dart';

class ImageBloc {
  ImageRepository _imageRepository;
  StreamController _imageListController;
  StreamSink<ApiResponse<List<Photos>>> get imageListSink =>
      _imageListController.sink;
  Stream<ApiResponse<List<Photos>>> get imageListStream =>
      _imageListController.stream;
  ImageBloc() {
    _imageListController = StreamController<ApiResponse<List<Photos>>>();
    _imageRepository = ImageRepository();
    fetchImageList();
  }

  fetchImageList() async {
    imageListSink.add(ApiResponse.loading('Fetching Images'));
    try {
      List<Photos> images = await _imageRepository.fetchImageList();
      imageListSink.add(ApiResponse.completed(images));
    } catch (e) {
      imageListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _imageListController?.close();
  }
}
