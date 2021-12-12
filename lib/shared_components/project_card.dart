import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectCardData {
  final double percent;
  final ImageProvider projectImage;
  final String projectName;
  final DateTime releaseTime;

  const ProjectCardData({
    required this.projectImage,
    required this.projectName,
    required this.releaseTime,
    required this.percent,
  });
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProgressIndicator(
          percent: data.percent,
          center: _ProfilImage(image: data.projectImage),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TitleText(data.projectName),
            ],
          ),
        )
      ],
    );
  }
}

/* -----------------------------> COMPONENTS <------------------------------ */
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.percent,
    required this.center,
    Key? key,
  }) : super(key: key);

  final double percent;
  final Widget center;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55,
      lineWidth: 2.0,
      percent: percent,
      center: center,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.blueGrey,
      progressColor: Theme.of(Get.context!).primaryColor,
    );
  }
}

class _ProfilImage extends StatelessWidget {
  const _ProfilImage({required this.image, Key? key}) : super(key: key);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      radius: 20,
      backgroundColor: Colors.white,
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.capitalize!,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

// class _SubtitleText extends StatelessWidget {
//   const _SubtitleText(this.data, {Key? key}) : super(key: key);

//   final String data;
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       data,
//       style: TextStyle(
//           fontSize: 11, color: Theme.of(context).textTheme.caption?.color),
//       maxLines: 1,
//       overflow: TextOverflow.ellipsis,
//     );
//   }
// }

// class _ReleaseTimeText extends StatelessWidget {
//   const _ReleaseTimeText(this.date, {Key? key}) : super(key: key);

//   final DateTime date;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: kNotifColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
//       child: Text(
//         DateFormat.yMMMd().format(date),
//         style: TextStyle(
//             fontSize: 9, color: Theme.of(context).colorScheme.onBackground),
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   }
// }
