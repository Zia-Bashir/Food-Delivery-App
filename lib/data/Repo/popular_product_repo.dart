import 'package:food_delivery_app/data/API/apiclient.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    Response response =
        await apiClient.getData(AppConstant.POPULAR_PRODUCTS_URL);
    return response;
  }
}
