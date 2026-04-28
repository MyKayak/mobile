import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class RaceWidget extends StatelessWidget {
  final String meetId;
  final int id;
  final String code;
  final int distance;
  final String division;
  final String category;
  final String boat;
  final String level;
  const RaceWidget({super.key, required this.meetId, required this.id, required this.code, required this.distance, required this.division, required this.category, required this.boat, required this.level});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String label = "";

    label += boat;
    label += " ";
    label += distance.toString();
    label += "m ";
    switch (division) {
      case "ALA":
        label += "Allievi A ";
      case "ALB":
        label += "Allievi B ";
      case "CDA":
        label += "Cadetti A ";
      case "CDB":
        label += "Cadetti B ";
      case "RA1":
        label += "Ragazzi primo anno ";
      case "RAG":
        label += "Ragazzi ";
      case "JUN":
        label += "Junior ";
      case "U23":
        label += "Under 23 ";
      case "SEN":
        label += "Senior ";
      case "DRA":
        label += "DIR A ";
      case "DRB":
        label += "DIR B ";
      default:
        if (division.startsWith("MA")){
          label += "Master ${division[2]} ";
        }
    }

    Icon genderIcon = const Icon(Icons.question_mark);

    switch (category) {
      case "M":
        label += "Maschile";
        genderIcon = const Icon(Icons.male, color: Colors.lightBlueAccent);
      case "F":
        label += "Femminile";
        genderIcon = const Icon(Icons.female, color: Colors.pinkAccent);
      case "X":
        label += "Misto";
        genderIcon = const Icon(Icons.people, color: Colors.amberAccent);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppCard(
        onTap: () {
          HapticFeedback.lightImpact();
          context.push('/meets/races/$meetId/heats/$id');
        },
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            genderIcon,
            const SizedBox(width: 8,),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
