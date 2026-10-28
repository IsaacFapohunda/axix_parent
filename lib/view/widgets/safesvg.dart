// import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/svg.dart';
//
// Widget safeSvg(
//     String path, {
//       double size = 20,
//       Color? color,
//     }) {
//   return SvgPicture.asset(
//     path,
//     width: size,
//     height: size,
//     fit: BoxFit.contain,
//     colorFilter: color == null
//         ? null
//         : ColorFilter.mode(color, BlendMode.srcIn),
//     placeholderBuilder: (_) => Icon(
//       Icons.image_outlined,
//       size: size,
//       color: color ?? Colors.grey,
//     ),
//   );
// }