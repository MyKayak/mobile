import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/athlete_detail.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../core/theme/app_theme.dart';

class TimeProgressionChart extends StatefulWidget {
  final List<TimeProgressionEntry> entries;

  const TimeProgressionChart({super.key, required this.entries});

  @override
  State<TimeProgressionChart> createState() => _TimeProgressionChartState();
}

class _TimeProgressionChartState extends State<TimeProgressionChart> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.entries.length < 2) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;
    
    final sortedEntries = List<TimeProgressionEntry>.from(widget.entries)
      ..sort((a, b) => a.date.compareTo(b.date));

    final spots = sortedEntries.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), -entry.value.timeMs.toDouble());
    }).toList();

    final times = sortedEntries.map((e) => e.timeMs).toList();
    final minTime = times.reduce((a, b) => a < b ? a : b);
    final maxTime = times.reduce((a, b) => a > b ? a : b);
    final verticalPadding = (maxTime - minTime) * 0.15;

    return Container(
      height: 200,
      padding: const EdgeInsets.only(right: 16, top: 10, bottom: 8),
      child: LineChart(
        LineChartData(
          minY: -maxTime.toDouble() - verticalPadding,
          maxY: -minTime.toDouble() + verticalPadding,
          showingTooltipIndicators: [],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: theme.colorScheme.outlineVariant.withAlpha(50),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedEntries.length) {
                    final dateStr = sortedEntries[index].date;
                    if (dateStr.length >= 4) {
                      final year = dateStr.substring(0, 4);
                      final isFirstOfYear = index == 0 || !sortedEntries[index - 1].date.startsWith(year);
                      
                      if (isFirstOfYear || index == sortedEntries.length - 1) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(year, style: mono.monoDate.copyWith(fontSize: 10)),
                        );
                      }
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 56,
                getTitlesWidget: (value, meta) {
                  if (value == meta.min || value == meta.max) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      TimeFormatter.formatTime(value.toInt().abs()),
                      style: mono.monoDate.copyWith(fontSize: 9),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.35,
              color: theme.colorScheme.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              showingIndicators: [],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 3.5,
                  color: theme.colorScheme.primary,
                  strokeWidth: 2,
                  strokeColor: theme.colorScheme.surface,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withAlpha(80),
                    theme.colorScheme.primary.withAlpha(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
              if (response != null && response.lineBarSpots != null && event is! FlPanEndEvent && event is! FlTapUpEvent) {
                final index = response.lineBarSpots!.first.spotIndex;
                if (index != _touchedIndex) {
                  setState(() {
                    _touchedIndex = index; 
                  });
                  HapticFeedback.selectionClick();
                }
              } else if (event is FlPanEndEvent || event is FlTapUpEvent) {
                setState(() {
                  _touchedIndex = null;
                });
              }
            },
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => theme.colorScheme.surfaceContainerHigh,
              tooltipBorderRadius: BorderRadius.circular(8),
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final entry = sortedEntries[spot.spotIndex];
                  return LineTooltipItem(
                    "${entry.date}\n",
                    theme.textTheme.labelSmall!.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    children: [
                      TextSpan(
                        text: TimeFormatter.formatTime(spot.y.toInt().abs()),
                        style: mono.monoTime.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
