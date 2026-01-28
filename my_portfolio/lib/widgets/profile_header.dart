// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/profile_provider.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final profile = context.watch<ProfileProvider>().profile;

//     return Container(
//       padding: const EdgeInsets.all(24),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 45,
//             backgroundImage: AssetImage("assets/profile.jpg"),
//           ).animate().scale(),
//           const SizedBox(width: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 profile.name,
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               Text(profile.role),
//               Text(profile.location),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
