// import 'package:dio/dio.dart';

class CylinderApi {
  // final Dio _dio = Dio();
  
  Future<List<Map<String, dynamic>>> getCylinders() async {
    // Mock API response
    return [
      {
        "id": "1",
        "name": "Random Cylinder 1 13",
        "price": 2500.00,
        "currency": "KES",
        "image_url": "lib/presentation/images/cylinder1.jpg"
      },
      {
        "id": "2",
        "name": "Random Cylinder 2 13",
        "price": 1500.00,
        "currency": "KES",
        "image_url": "lib/presentation/images/cylinder2.jpg"
      },
      {
        "id": "3",
        "name": "Random Cylinder 3 13S",
        "price": 1750.00,
        "currency": "KES",
        "image_url": "lib/presentation/images/cylinder3.jpg"
      },
    ];
  }
}