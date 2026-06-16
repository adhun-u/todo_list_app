import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/responsive/responsive.dart';
import 'package:todo_list/core/theme/app_colors.dart';
import 'package:todo_list/core/theme/app_theme.dart';

class DeleteDialog extends StatelessWidget {
  final Function()? onDeleteClicked;
  const DeleteDialog({super.key, this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().currentTheme == .dark;
    return Dialog(
      child: Container(
        height: context.dHeight * 0.21,
        width: context.dWidth,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSecondary : AppTheme.lightSecondary,
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.redColor.shade200,
                child: Icon(CupertinoIcons.delete),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to delete?',
                style: TextStyle(
                  fontSize: context.fontSize(16),
                  letterSpacing: -0.32,
                  fontWeight: .w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.greyColor,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onDeleteClicked?.call();
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.redColor,
                        ),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
