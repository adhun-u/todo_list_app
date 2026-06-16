import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/responsive/responsive.dart';
import 'package:todo_list/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final String? title;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.maxLength,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().currentTheme == .dark;
    final borderColor = isDark ? AppTheme.lightPrimary : AppTheme.darkPrimary;
    return Column(
      crossAxisAlignment: .start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: context.fontSize(16),
              letterSpacing: -0.37,
              fontWeight: .w500,
            ),
          ),
          const SizedBox(height: 10),
        ],
        Container(
          decoration: BoxDecoration(color: context.colorScheme.primary),
          child: Center(
            child: TextField(
              controller: controller,
              maxLength: maxLength,
              maxLines: maxLines,

              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: context.fontSize(12),
                  color: isDark
                      ? AppTheme.lightSecondary
                      : AppTheme.darkSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 1.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
