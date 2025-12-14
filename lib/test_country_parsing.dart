// import 'package:almonafs_flutter/features/home/data/model/getAllcountry.dart';

// void main() {
//   final Map<String, dynamic> jsonResponse = {
//     "success": true,
//     "message": "Data fetched successfully",
//     "data": {
//       "countries": [
//         {
//           "_id": "68b6f5eb5a1683092ed5f4e7",
//           "name": "Albania",
//           "images": ["url1", "url2"],
//         },
//       ],
//     },
//   };

//   try {
//     final result = GetAllCountry.fromJson(jsonResponse);
//     print('Status: ${result.status}');
//     print('Data length: ${result.data?.length}');
//     if (result.data != null && result.data!.isNotEmpty) {
//       print('First country: ${result.data![0].name}');
//     } else {
//       print('Data is empty or null');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
