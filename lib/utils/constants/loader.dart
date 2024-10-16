import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class ShowLoader{

  static isLoadingProgress(bool show) {
   return Visibility(
     child: Center(
         child: Lottie.asset(
           "assets/jsons/progress_bar.json",
           height: 140,width: 140
         )
     ),
     maintainSize: true,
     maintainAnimation: true,
     maintainState: true,
     visible: show,
   );

  }
}