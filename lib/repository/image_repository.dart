import 'package:pexel/models/pexel_image_api_response.dart';
import 'package:pexel/networking/api_base_helper.dart';

class ImageRepository {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<List<Photos>> fetchImageList() async {
    final response = await _helper.get("v1/curated?page=1&per_page=40");
    return PexelImageApiResponseModel.fromJson(response).photos;
  }
}
