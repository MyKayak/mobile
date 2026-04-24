import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class MeetWidget extends StatelessWidget {
  final String id;
  final String date;
  final String name;
  final String location;
  const MeetWidget({super.key, required this.id, required this.date, required this.name, required this.location});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.push('/meets/races/$id');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outline.withAlpha(60),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    location,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(date, style: mono.monoDate),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
