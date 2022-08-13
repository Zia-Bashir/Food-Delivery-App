import 'package:food_delivery_app/data/API/apiclient.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    Response response =
        await apiClient.getData(AppConstant.RECOMMENDED_PRODUCTS_URL);
    return response;
  }
}
