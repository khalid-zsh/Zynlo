import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // 🔥 Primary Brand Colors
  static const Color primary = Color(0xFF0F9D8F);
  static const Color primaryLight = Color(0xFF3FC1B5);
  static const Color primaryDark = Color(0xFF0B7A6E);

  // 🎨 Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF111827);

  // 🧱 UI Colors
  static const Color scaffold = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);

  // 💬 Chat Bubble Colors
  static const Color sentMessage = Color(0xFF0F9D8F);
  static const Color receivedMessage = Color(0xFFE5E7EB);

  // ✍️ Text Colors (Light Mode)
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);

  // ✍️ Text Colors (Dark Mode)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);

  // 🎯 Selection Colors
  static const Color selectedItem = Color(0xFFE6FFFA); // light teal bg
  static const Color unselectedItem = Colors.transparent;

  // 🔘 Tab / Icon Colors
  static const Color iconActive = Color(0xFF0F9D8F);
  static const Color iconInactive = Color(0xFF9CA3AF);

  // 📩 Message Status Colors
  static const Color messageUnread = Color(0xFF0F9D8F); // bold / highlight
  static const Color messageRead = Color(0xFF6B7280);   // faded text

  // ✔ Tick Colors (like WhatsApp)
  static const Color tickSingle = Color(0xFF9CA3AF); // sent
  static const Color tickDouble = Color(0xFF9CA3AF); // delivered
  static const Color tickRead = Color(0xFF0F9D8F);   // seen (blue/teal)

  // 🟢 Online / Offline Status
  static const Color online = Color(0xFF22C55E);
  static const Color offline = Color(0xFF9CA3AF);

  // 🚦 Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
}