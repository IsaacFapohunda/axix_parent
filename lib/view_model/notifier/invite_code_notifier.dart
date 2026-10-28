// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../state/invite_code_state.dart';
//
// final inviteCodeProvider = StateNotifierProvider<InviteCodeNotifier, InviteCodeState>(
//       (ref) => InviteCodeNotifier(),
// );
//
// class InviteCodeNotifier extends StateNotifier<InviteCodeNotifier> {
//   InviteCodeNotifier() : super(const InviteCodeNotifier()) {
//     startCountdown();
//   }
//
//   Timer? _timer;
//
//   void startCountdown() {
//     _timer?.cancel();
//     state = state.copyWith(countdown: 59);
//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (state.countdown > 0) {
//         state = state.copyWith(countdown: state.countdown - 1);
//       } else {
//         t.cancel();
//       }
//     });
//   }
//
//   void onCodeChanged(String code) {
//     state = state.copyWith(code: code, isError: false);
//   }
//
//   Future<void> verify() async {
//     if (!state.isComplete) return;
//
//     state = state.copyWith(isLoading: true);
//
//     // TEMP - you will replace with endpoint later
//     await Future.delayed(const Duration(seconds: 1));
//
//     const correctCode = "125585"; // your test code
//     if (state.code == correctCode) {
//       state = state.copyWith(isLoading: false, isError: false);
//       // TODO: navigate to next screen
//     } else {
//       state = state.copyWith(isLoading: false, isError: true);
//     }
//   }
//
//   void resend() {
//     // TODO: call resend endpoint later
//     startCountdown();
//     state = state.copyWith(code: '', isError: false);
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }