part of shared_components;

class ProfileCompletionReportCardData {
  final double percent;
  final String title;

  const ProfileCompletionReportCardData(
      {required this.percent, required this.title});
}

class ProgressReportCard extends StatelessWidget {
  const ProgressReportCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ProfileCompletionReportCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacing),
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(111, 88, 255, 1),
            Color.fromRGBO(157, 86, 248, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Spacer(),
          _Indicator(percent: data.percent),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.percent, Key? key}) : super(key: key);

  final double percent;

  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return CircularPercentIndicator(
      radius: 140,
      lineWidth: 15,
      percent: percent,
      circularStrokeCap: CircularStrokeCap.round,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (percent * 100).toString() + " %",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "Completed",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
        ],
      ),
      progressColor: themeContext.colorScheme.onBackground,
      backgroundColor: themeContext.colorScheme.onBackground.withOpacity(.3),
    );
  }
}
