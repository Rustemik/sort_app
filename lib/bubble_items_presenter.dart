import 'package:flutter/material.dart';
import 'package:sort_app/sort_item.dart';

class BubbleItemsPresenter extends StatelessWidget {
  List<SortItem> _items;

  BubbleItemsPresenter({
    super.key,
    required List<SortItem> items,
  }) : _items = items;

  @override
  Widget build(BuildContext context) {
    double fieldWidth = 360 - 10;
    double fieldHeight = 300;
    double padding = _items.length / 100;
    double width = fieldWidth / _items.length;
    int maxValue = _items
        .reduce((item, element) => item.value > element.value ? item : element)
        .value;
    double onePercent = maxValue / 100;
    double onePercentHeight = fieldHeight / 100;
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ..._items.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Container(
                height: (item.value / onePercent) * onePercentHeight,
                width: width - padding * 2,
                color: item.isCurrent ? Color(0xff00eeff) : Color(0xff392a5a),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
