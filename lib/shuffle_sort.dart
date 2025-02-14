import 'dart:math';

import 'package:sort_app/sort_item.dart';

Future<void> shuffleSort(List<SortItem> array) async {
  final random = Random();
  //List<SortItem> shuffled = List<SortItem>.from(array);

  for (int i = array.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    SortItem temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
}

// void shuffle([Random? random]) {
//     random ??= Random();

//     int length = this.length;
//     while (length > 1) {
//       int pos = random.nextInt(length);
//       length -= 1;
//       var tmp = this[length];
//       this[length] = this[pos];
//       this[pos] = tmp;
//     }
//   }
