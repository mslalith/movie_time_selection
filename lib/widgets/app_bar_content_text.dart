import 'package:flutter/material.dart';
import 'package:movie_time_selection/themes/app_theme.dart';
import 'package:movie_time_selection/widgets/underline_text.dart';

class AppBarContentText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UnderlineText(text: 'VR —'),
        UnderlineText(text: 'CITY R'),
        SizedBox(height: 12.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: AppTheme.onAppBarColor,
            ),
            SizedBox(width: 12.0),
            Text(
              '4.8',
              style: TextStyle(
                color: AppTheme.onAppBarColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
