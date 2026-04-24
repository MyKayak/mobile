import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class MedalBadge extends StatelessWidget {
  final int count;
  final Gradient? gradient;
  final Color? shadowColor;
  final bool isTotal;

  const MedalBadge({
    super.key,
    required this.count,
    this.gradient,
    this.shadowColor,
    this.isTotal = false,
  });

  factory MedalBadge.gold(int count) => MedalBadge(
        count: count,
        gradient: AppColors.goldGradient,
        shadowColor: AppColors.gold,
      );

  factory MedalBadge.silver(int count) => MedalBadge(
        count: count,
        gradient: AppColors.silverGradient,
        shadowColor: AppColors.silver,
      );

  factory MedalBadge.bronze(int count) => MedalBadge(
        count: count,
        gradient: AppColors.bronzeGradient,
        shadowColor: AppColors.bronze,
      );

  factory MedalBadge.total(int count) => MedalBadge(
        count: count,
        isTotal: true,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;
    final countStr = count.toString();
    
    return Center(
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: !isTotal ? gradient : null,
          color: isTotal ? theme.colorScheme.surfaceContainerHighest : null,
          shape: BoxShape.circle,
          border: isTotal
              ? Border.all(color: AppColors.outline, width: 1)
              : Border.all(
                  color: Colors.white.withAlpha(60),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
          boxShadow: [
            if (!isTotal && shadowColor != null)
              BoxShadow(
                color: shadowColor!.withAlpha(80),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          countStr,
          style: mono.monoMedal.copyWith(
            fontSize: countStr.length > 2 ? 10 : 12,
            color: isTotal ? AppColors.onSurface : Colors.black87,
          ),
        ),
      ),
    );
  }
}
