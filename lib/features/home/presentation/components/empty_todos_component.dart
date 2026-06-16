import 'package:flutter/material.dart';
import 'package:todo_list/core/constants/app_assets.dart';
import 'package:todo_list/core/responsive/responsive.dart';

class EmptyTodosComponent extends StatelessWidget {
  const EmptyTodosComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              AppAssets.emptyStateImage,
              height: context.dWidth * 0.55,
              width: context.dWidth * 0.55,
            ),
          ),
        ),
        Text(
          'No Todos Found',
          style: TextStyle(
            fontSize: context.fontSize(16),
            fontWeight: .w600,
            letterSpacing: -0.41,
          ),
        ),
      ],
    );
  }
}
