import 'package:flutter/material.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/constants.dart';
import 'package:sewa_digital/data/model/product_detail_response.dart';
import 'package:sewa_digital/data/model/variant_response.dart';

typedef ChoiceChipsCallback = void Function(List variation);

class ChoiceChips extends StatefulWidget {
  final ChoiceOptionResponse chipName;
  final List<ChoiceOptionResponse> choiceOptions;
  final ChoiceChipsCallback? choiceChipsCallback;
  final List choice;
  final int index;

  const ChoiceChips({
    Key? key,
    required this.chipName,
    required this.choice,
    required this.index,
    required this.choiceOptions,
    this.choiceChipsCallback,
  }) : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String _selected = "";

  @override
  void initState() {
    _selected = widget.chipName.options!.first.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: List.generate(widget.chipName.options!.length, (index) {
          var item = widget.chipName.options![index];
          return Column(
            children: [
              ChoiceChip(
                backgroundColor: Colors.transparent,
                label: Text(item.toString()),
                labelStyle: TextStyle(
                    color: _selected == item.toString()
                        ? Colors.white
                        : Theme.of(context).brightness == Brightness.dark
                            ? ColorManager.orange
                            : ColorManager.black),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: _selected == item.toString()
                          ? Colors.transparent
                          : Theme.of(context).brightness == Brightness.dark
                              ? ColorManager.orange
                              : ColorManager.black,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                selectedColor: ColorManager.orange,
                selected: _selected == item.toString(),
                onSelected: (selected) {
                  setState(() {
                    _selected = item.toString();
                    for (int i = 0; i < widget.choice.length; i++) {
                      if (widget.index == i) {
                        widget.choice.removeAt(widget.index);
                        widget.choice.insert(widget.index,
                            VariantDataResponse(_selected).toMap());
                        widget.choiceChipsCallback!(widget.choice);
                      } else {}
                    }
                  });
                },
              ),
            ],
          );
        })
        // _buildChoiceList(),
        );
  }
}
