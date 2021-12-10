import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paylinc/constants/app_constants.dart';

class UpgradePremiumCard extends StatelessWidget {
  const UpgradePremiumCard({
    required this.onPressed,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Color? backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(kBorderRadius),
      color: Theme.of(context).primaryColorDark,
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: onPressed,
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 150,
            maxWidth: 250,
            minHeight: 150,
            maxHeight: 250,
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                ),
                child: SvgPicture.asset(
                  ImageVectorPath.happy,
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: _Info(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const SizedBox(height: 2),
        _subtitle(),
        const SizedBox(height: 10),
        _price(),
      ],
    );
  }

  Widget _title() {
    return const Text(
      "Upgrade your account",
    );
  }

  Widget _subtitle() {
    return Text(
      "in order to get full access",
      style: Theme.of(Get.context!).textTheme.caption,
    );
  }

  Widget _price() {
    return Builder(builder: (context) {
      var themeContext = Theme.of(context);
      return Container(
        decoration: BoxDecoration(
          color: themeContext.textTheme.caption?.color?.withOpacity(.1),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 10,
              color: themeContext.colorScheme.onBackground,
              fontWeight: FontWeight.w200,
            ),
            children: [
              const TextSpan(text: "10\$ "),
              TextSpan(
                text: "per month",
                style: TextStyle(
                  color: themeContext.textTheme.caption?.color,
                ),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    });
  }
}
