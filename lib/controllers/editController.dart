// import 'package:get/get.dart';
// import '../model/singleOrder.dart';

// import './repository.dart';

// class EditOrderController extends GetxController {
//   static EditOrderController get to => Get.find();
//   Future<Map<String, dynamic>> myVeggieList;

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     // myVeggieList.obs;

//     myVeggieList = getEditOrderDetails();
//   }

//   var productList = List<SingleOrderModel>().obs;

//   Future<Map<String, dynamic>> getEditOrderDetails() async {
//     return await EditRepository.fetchOrder();
//   }

//   Future<void> refresh() {
//     print('refreshing');
//     myVeggieList = getEditOrderDetails();

//     return myVeggieList;
//   }
// }
