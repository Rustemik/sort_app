import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:lottie/lottie.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:sort_app/bubble_items_presenter.dart';
import 'package:sort_app/shuffle_sort.dart';
import 'package:sort_app/sort_item.dart';

class BubbleHome extends StatefulWidget {
  BubbleHome({super.key});

  @override
  State<BubbleHome> createState() => _HomeState();
}

class _HomeState extends State<BubbleHome> {
  bool _isBusy = false;
  List<SortItem> items = List<SortItem>.generate(40, (i) => SortItem(i + 1));
  //List<int> items = [15, 9, 46, 8, 7, 5, 67, 15, 92, 81, 11, 17, 99, 88, 45, 1];

  Future<void> bubbleSort(List<SortItem> array) async {
    for (int i = 1; i < array.length; i++) {
      for (int j = 0; j < array.length - i; j++) {
        var item1 = array[j];
        var item2 = array[j + 1];

        if (item1.value > item2.value) {
          array[j] = item2;
          array[j + 1] = item1;

          item1.isCurrent = true;
          item2.isCurrent = false;
        } else {
          item1.isCurrent = false;
          item2.isCurrent = true;
        }

        setState(() {});
        await Future.delayed(const Duration(milliseconds: 1));
      }
    }
  }

  Future<void> shuffleSort(List<SortItem> array) async {
    final random = Random();
    for (int i = array.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      SortItem temp = array[i];
      array[i] = array[j];
      array[j] = temp;

      setState(() {});
      await Future.delayed(const Duration(milliseconds: 60));
    }
  }

  void sortClick() async {
    setState(() {
      _isBusy = true;
    });

    dev.log('sorting...');
    await bubbleSort(items);
    for (var item in items) {
      item.isCurrent = false;
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 40));
    }

    setState(() {
      _isBusy = false;
    });
  }

  // void shuffleClick() async {
  //   setState(() {
  //     _isBusy = true;
  //   });

  //   //log('shuffle...');
  //   await shuffleSort(items);
  //   for (var item in items) {
  //     //item.isCurrent = false;
  //     setState(() {});

  //   }

  //   setState(() {
  //     _isBusy = false;
  //   });
  //   await Future.delayed(const Duration(milliseconds: 40));
  // }
  // }

  void shuffleClick() async {
    dev.log('shuffle...');
    shuffleSort(items);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 234, 225),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 234, 225),
        toolbarHeight: 130,
        centerTitle: true,
        title: OutlinedText(
          text: Text(
            'bubble sort',
            style: TextStyle(
              color: Color(0xff00eeff),
              fontSize: 70,
              fontFamily: 'Bubble',
              //fontWeight: FontWeight.bold,
            ),
          ),
          strokes: [
            OutlinedTextStroke(
              color: Color(0xff392a5a),
              width: 8,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      //border: Border.all(color: Colors.blueGrey),
                      ),
                  height: 300,
                  width: 360,
                  child: BubbleItemsPresenter(
                    items: items,
                  ),
                ),
                SizedBox(height: 60),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ImageButton(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              left: 25,
                              top: 40,
                              child: Text(
                                'mix',
                                style: TextStyle(
                                  color: Color(0xff392a5a),
                                  fontSize: 35,
                                  fontFamily: 'Bubble',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: _isBusy ? null : shuffleClick,
                        unpressedImage:
                            Image.asset('assets/images/bubble_button.png'),
                        pressedImage: Image.asset(
                          'assets/images/bubble_button.png',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ImageButton(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              left: 20,
                              top: 35,
                              child: Text(
                                'sort',
                                style: TextStyle(
                                  color: Color(0xff392a5a),
                                  fontSize: 35,
                                  fontFamily: 'Bubble',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: _isBusy ? null : sortClick,
                        unpressedImage:
                            Image.asset('assets/images/bubble_button.png'),
                        pressedImage: Image.asset(
                          'assets/image/bubble_button.png',
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blueGrey,
                //       foregroundColor: Colors.white,
                //     ),
                //     onPressed: _isBusy ? null : shuffleClick,
                //     child: Text('Перемешать'),
                //   ),
                // ),

                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.blueGrey,
                //       foregroundColor: Colors.white,
                //     ),
                //     onPressed: _isBusy ? null : sortClick,
                //     child: Text(_isBusy ? 'Стоп' : 'Отсортировать'),
                //   ),
                // ),

                // SizedBox(
                //   width: 100,
                //   height: 100,
                //   child: IconButton(
                //     icon: Image.asset('assets/images/bubble_button.png'),
                //     onPressed: _isBusy ? null : sortClick,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Align(
//   alignment: Alignment.bottomLeft,
//   child: SizedBox(
//     height: 200,
//     width: 200,
//     child: Lottie.network(
//         'https://lottie.host/19594b89-fedd-4526-b706-3467aee0785f/9RQeHtlbZU.json'),
//   ),
// ),
