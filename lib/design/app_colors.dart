import 'dart:ui';

abstract final class AppColors {
  // ── Primary Issue ──
  static const Color primaryIssue = Color(0xff000862);
  static const Color paletIssue = Color(0xff00B7FF);
  static const Color deepBlueIssue = Color(0xff135080);
  static const Color gradientIssue = Color(0xFF1A237E);

  // ── Success / Green ──
  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF16A34A);
  static const Color successDarker = Color(0xFF2E7D32);
  static const Color successBg = Color(0xFFDCFCE7);
  static const Color successBgLight = Color(0xFFE8F5E8);

  // ── Error / Red ──
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorDarker = Color(0xFFC62828);
  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color errorBgLight = Color(0xFFFFEBEE);

  // ── Warning / Amber ──
  static const Color warning = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color warningBgLight = Color(0xFFFFF3E0);

  // ── Neutral / Text ──
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF374151);
  static const Color textTertiary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textHint = Color(0xFF6B7280);
  static const Color textPlaceholder = Color(0xFF94A3B8);

  // ── Border ──
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDivider = Color(0xFFCBD5E1);

  // ── Surface / Background ──
  static const Color surface = Color(0xFFF8FAFC);
  static const Color surfaceAlt = Color(0xFFF8F9FA);
  static const Color surfaceLight = Color(0xFFF1F5F9);
  static const Color surfaceLighter = Color(0xFFFAFAFA);
}
