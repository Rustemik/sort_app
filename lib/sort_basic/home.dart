import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sort_app/sort_basic/items_presenter.dart';
import 'package:sort_app/sort_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isBusy = false;
  List<SortItem> items = List<SortItem>.generate(40, (i) => SortItem(i + 1));

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

  void sortClick() async {
    setState(() {
      _isBusy = true;
    });

    log('sorting...');
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

  void shuffleClick() {
    log('shuffle...');
    setState(() {
      items.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Сортировка пузырьком'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
              ),
              height: 250,
              width: 360,
              child: ItemsPresenter(
                items: items,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isBusy ? null : shuffleClick,
                child: Text('Перемешать'),
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isBusy ? null : sortClick,
                child: Text(_isBusy ? 'Стоп' : 'Отсортировать'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
