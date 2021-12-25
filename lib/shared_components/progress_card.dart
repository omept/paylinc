import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paylinc/constants/app_constants.dart';

class ProgressCardData {
  final int totalWallets;

  const ProgressCardData({
    required this.totalWallets,
  });
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    required this.data,
    required this.onPressedCheck,
    Key? key,
  }) : super(key: key);

  final ProgressCardData data;
  final Function() onPressedCheck;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(kBorderRadius),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                offset: const Offset(10, 30),
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset(
                    ImageVectorPath.happy2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kSpacing,
              top: kSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You have ${data.totalWallets} vendor wallets.",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: kSpacing),
                Text(
                  "create a wallet for your vendor acount",
                  style:
                      TextStyle(color: themeContext.textTheme.caption?.color),
                ),
                const SizedBox(height: kSpacing / 2),
                ElevatedButton(
                  onPressed: onPressedCheck,
                  child: const Text("Create"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
