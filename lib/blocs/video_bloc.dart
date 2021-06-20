import 'dart:async';

import 'package:pexel/models/pexel_video_api_response.dart';
import 'package:pexel/networking/api_response.dart';
import 'package:pexel/repository/video_repository.dart';

class VideoBloc {
  VideoRepository _videoRepository;
  StreamController _videoListController;
  StreamSink<ApiResponse<List<Videos>>> get videoListSink =>
      _videoListController.sink;
  Stream<ApiResponse<List<Videos>>> get videoListStream =>
      _videoListController.stream;
  VideoBloc() {
    _videoListController = StreamController<ApiResponse<List<Videos>>>();
    _videoRepository = VideoRepository();
    fetchVideoList();
  }

  fetchVideoList() async {
    videoListSink.add(ApiResponse.loading('Fetching Videos'));
    try {
      List<Videos> videos = await _videoRepository.fetchVideoList();
      videoListSink.add(ApiResponse.completed(videos));
    } catch (e) {
      videoListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _videoListController?.close();
  }
}
