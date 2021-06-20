import 'package:pexel/models/pexel_video_api_response.dart';
import 'package:pexel/networking/api_base_helper.dart';

class VideoRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Videos>> fetchVideoList() async {
    final response = await _helper.get("videos/popular?page=1&per_page=40");
    return PexelVideoApiResponseModel.fromJson(response).videos;
  }
}
