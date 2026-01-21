import 'package:bctpay/globals/index.dart';

// Relaxed session-expiry handling: avoid hard logout loops triggered by
// background 401s (e.g., legacy endpoints while logged in via core).
void sessionExpired(String msg, BuildContext context) {
  showToast(msg.isNotEmpty ? msg : "Session expired");
  // Do not force logout/navigation; keep user in-app.
}
