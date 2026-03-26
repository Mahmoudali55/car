import 'dart:io';

void main() async {
  final libDir = Directory('lib');
  if (!await libDir.exists()) {
    print('lib directory not found');
    return;
  }

  int modifiedFiles = 0;

  final entities = await libDir.list(recursive: true).toList();
  for (var entity in entities) {
    if (entity is File && entity.path.endsWith('.dart')) {
      // Skip the theme folder to avoid breaking AppColor itself
      if (entity.path.contains('core\\theme\\') || entity.path.contains('core/theme/')) {
        continue;
      }

      String content = await entity.readAsString();
      bool modified = false;

      // Replace Colors.white constants
      if (content.contains('Colors.white10')) {
        content = content.replaceAll(
          'Colors.white10',
          'AppColor.blackTextColor(context).withValues(alpha: 0.10)',
        );
        modified = true;
      }
      if (content.contains('Colors.white12')) {
        content = content.replaceAll(
          'Colors.white12',
          'AppColor.blackTextColor(context).withValues(alpha: 0.12)',
        );
        modified = true;
      }
      if (content.contains('Colors.white24')) {
        content = content.replaceAll(
          'Colors.white24',
          'AppColor.blackTextColor(context).withValues(alpha: 0.24)',
        );
        modified = true;
      }
      if (content.contains('Colors.white30')) {
        content = content.replaceAll(
          'Colors.white30',
          'AppColor.blackTextColor(context).withValues(alpha: 0.30)',
        );
        modified = true;
      }
      if (content.contains('Colors.white38')) {
        content = content.replaceAll(
          'Colors.white38',
          'AppColor.blackTextColor(context).withValues(alpha: 0.38)',
        );
        modified = true;
      }
      if (content.contains('Colors.white54')) {
        content = content.replaceAll(
          'Colors.white54',
          'AppColor.blackTextColor(context).withValues(alpha: 0.54)',
        );
        modified = true;
      }
      if (content.contains('Colors.white60')) {
        content = content.replaceAll(
          'Colors.white60',
          'AppColor.blackTextColor(context).withValues(alpha: 0.60)',
        );
        modified = true;
      }
      if (content.contains('Colors.white70')) {
        content = content.replaceAll(
          'Colors.white70',
          'AppColor.blackTextColor(context).withValues(alpha: 0.70)',
        );
        modified = true;
      }
      if (content.contains('Colors.white82')) {
        content = content.replaceAll(
          'Colors.white82',
          'AppColor.blackTextColor(context).withValues(alpha: 0.82)',
        );
        modified = true;
      }
      if (content.contains('Colors.white87')) {
        content = content.replaceAll(
          'Colors.white87',
          'AppColor.blackTextColor(context).withValues(alpha: 0.87)',
        );
        modified = true;
      }

      if (content.contains('Colors.white')) {
        // Find Colors.white that's NOT already followed by .withOpacity or .withValues
        content = content.replaceAllMapped(
          RegExp(r'Colors\.white(?!\.with)'),
          (_) => 'AppColor.blackTextColor(context)',
        );

        // Find Colors.white.withOpacity(0.5)
        content = content.replaceAllMapped(
          RegExp(r'Colors\.white\.withOpacity'),
          (_) => 'AppColor.blackTextColor(context).withOpacity',
        );

        // Find Colors.white.withValues(alpha: 0.5)
        content = content.replaceAllMapped(
          RegExp(r'Colors\.white\.withValues'),
          (_) => 'AppColor.blackTextColor(context).withValues',
        );
        modified = true;
      }

      if (content.contains('Color(0xFF0F172A)')) {
        content = content.replaceAllMapped(
          RegExp(r'const Color\(0xFF0F172A\)'),
          (_) => 'AppColor.scaffoldColor(context)',
        );
        content = content.replaceAllMapped(
          RegExp(r'Color\(0xFF0F172A\)'),
          (_) => 'AppColor.scaffoldColor(context)',
        );
        modified = true;
      }

      if (content.contains('Color(0xff0f172a)')) {
        content = content.replaceAllMapped(
          RegExp(r'const Color\(0xff0f172a\)'),
          (_) => 'AppColor.scaffoldColor(context)',
        );
        content = content.replaceAllMapped(
          RegExp(r'Color\(0xff0f172a\)'),
          (_) => 'AppColor.scaffoldColor(context)',
        );
        modified = true;
      }

      // If we used AppColor but didn't import it, add import
      if (modified &&
          content.contains('AppColor.') &&
          !content.contains("import 'package:car/core/theme/app_colors.dart';")) {
        // Insert after material import if exists
        if (content.contains("import 'package:flutter/material.dart';")) {
          content = content.replaceFirst(
            "import 'package:flutter/material.dart';",
            "import 'package:flutter/material.dart';\nimport 'package:car/core/theme/app_colors.dart';",
          );
        } else {
          content = "import 'package:car/core/theme/app_colors.dart';\n" + content;
        }
      }

      // Remove const from widgets that now use (context) making them non-static
      if (modified) {
        content = content.replaceAllMapped(
          RegExp(
            r'const (Text|Icon|BoxDecoration|Container|SizedBox|Padding|Center|Divider|Row|Column|Expanded|SpinKitFoldingCube)\(',
          ),
          (match) => '${match.group(1)}(',
        );
        content = content.replaceAllMapped(RegExp(r'const TextStyle\('), (_) => 'TextStyle(');
        content = content.replaceAllMapped(RegExp(r'const EdgeInsets\.'), (_) => 'EdgeInsets.');

        await entity.writeAsString(content);
        modifiedFiles++;
        print('Updated: ${entity.path}');
      }
    }
  }

  print('Modified $modifiedFiles files.');
}
