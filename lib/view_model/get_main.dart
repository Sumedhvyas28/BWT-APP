import 'dart:io';

dynamic getHeader = {
  HttpHeaders.authorizationHeader:
      'Bearer 214|UIuQRrxbsjw9LDAtfEynMH2GOyg0fBZkrYQirTBi2ec67929'
};

dynamic postHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.authorizationHeader:
      'Bearer 214|UIuQRrxbsjw9LDAtfEynMH2GOyg0fBZkrYQirTBi2ec67929'
};


// ApiResponse<List<Product>> allProductList = ApiResponse.Loading();

//   setProductList(ApiResponse<List<Product>> response) {
//     allProductList = response;
//     notifyListeners();
//   }

//   Future<void> getAllProduct() async {
//     setProductList(ApiResponse.Loading());
//     _myRepo.showProductRepo(getHeader).then((value) {
//       setProductList(ApiResponse.completed(value));
//     }).onError((error, stackTrace) {
//       setProductList(ApiResponse.error(error.toString()));
//     });
//     notifyListeners();
//   }