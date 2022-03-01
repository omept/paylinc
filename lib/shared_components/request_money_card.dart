part of shared_components;

class RequestMoneyCard extends StatelessWidget {
  const RequestMoneyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(kBorderRadius),
      color: Theme.of(context).cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(kBorderRadius),
        onTap: () => Get.offNamed(Routes.request_money),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 250,
            maxWidth: 350,
            minHeight: 200,
            maxHeight: 200,
          ),
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  ImageVectorPath.happy,
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: _InfoRM(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRM extends StatelessWidget {
  const _InfoRM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Request\nMoney\n",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "receive funds into a wallet",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
