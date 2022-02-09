import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';

class WalletCardData {
  final int totalWallets;

  const WalletCardData({
    required this.totalWallets,
  });
}

class WalletCard extends StatelessWidget {
  const WalletCard({
    required this.data,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final WalletCardData data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                    "add a wallet for your vendor acount",
                    style:
                        TextStyle(color: themeContext.textTheme.caption?.color),
                  ),
                  const SizedBox(height: kSpacing / 2),
                  ElevatedButton(
                    onPressed: () {
                      Get.offNamed(Routes.create_wallet);
                    },
                    child: const Text("Add"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
