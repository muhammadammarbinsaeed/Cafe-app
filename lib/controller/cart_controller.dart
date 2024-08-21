
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';

class NewCartController extends GetxController {
  var isWebLoading=true.obs;
   List<dynamic> products=[

  ].obs;
   List<dynamic> selectedProducts=[].obs;

   increment(int index){
     selectedProducts[index]["quantity"]=selectedProducts[index]["quantity"]+1;
     
   }
   deccrement(int index){
     if(selectedProducts[index]["quantity"]!=1){
     selectedProducts[index]["quantity"]=selectedProducts[index]["quantity"]-1;
     
     }
     else{
       AlertDialog(
              title: const Text('Warning'),
              content: const Text('AtLeast one item should be selected'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('OK'),
                ),
              ],
            );     
     }
     
   }



 


 
}
