// import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:flutter/material.dart';

// /// The [AppTheme] defines light and dark themes for the app.
// ///
// /// Theme setup for FlexColorScheme package v8.
// /// Use same major flex_color_scheme package version. If you use a
// /// lower minor version, some properties may not be supported.
// /// In that case, remove them after copying this theme to your
// /// app or upgrade the package to version 8.4.0.
// ///
// /// Use it in a [MaterialApp] like this:
// ///
// /// MaterialApp(
// ///   theme: AppTheme.light,
// ///   darkTheme: AppTheme.dark,
// /// );
// abstract final class AppTheme {
//   // The FlexColorScheme defined light mode ThemeData.

//   static ThemeData light =
//       FlexThemeData.light(
//         scheme: FlexScheme.shadViolet,
//         // ... 나머지 설정들
//         subThemesData: const FlexSubThemesData(
//           inputDecoratorBorderType: FlexInputBorderType.outline,
//           inputDecoratorRadius: 12.0,
//           inputDecoratorUnfocusedHasBorder: true,
//           inputDecoratorFocusedHasBorder: true,
//           inputDecoratorFocusedBorderWidth: 2.0,
//         ),
//       ).copyWith(
//         focusColor: Colors.transparent,
//         inputDecorationTheme: InputDecorationTheme(
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.blue, width: 2), // ← 파란색 고정
//           ),
//         ),
//       );
// }
