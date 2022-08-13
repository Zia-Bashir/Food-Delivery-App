import 'package:flutter/material.dart';
import 'package:food_delivery_app/Utils/colors.dart';
import 'package:food_delivery_app/Utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class ExtendableText extends StatefulWidget {
  const ExtendableText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  State<ExtendableText> createState() => _ExtendableTextState();
}

class _ExtendableTextState extends State<ExtendableText> {
  late String firstPart;
  late String secondPart;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstPart = widget.text.substring(0, textHeight.toInt());
      secondPart =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstPart = widget.text;
      secondPart = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          //color: Colors.amber,

          child: secondPart.isEmpty
              ? SmallText(text: firstPart)
              : Column(
                  children: [
                    SmallText(
                      size: Dimensions.size15,
                      text: hiddenText
                          ? ("$firstPart...")
                          : (firstPart + secondPart),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          hiddenText = !hiddenText;
                        });
                      },
                      child: Row(
                        children: [
                          SmallText(
                            text: hiddenText ? "Show more" : "Show less",
                            color: AppColors.mainColor,
                          ),
                          Icon(
                            hiddenText
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
