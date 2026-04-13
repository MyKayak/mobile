import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import '../widgets/team_search_widget.dart';

enum SearchMode { athletes, teams }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchMode mode = SearchMode.teams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return SegmentedButton<SearchMode>(
                  segments: const [
                    ButtonSegment<SearchMode>(
                      value: SearchMode.athletes,
                      label: Text('Athletes'),
                      icon: Icon(Icons.person),
                    ),
                    ButtonSegment<SearchMode>(
                      value: SearchMode.teams,
                      label: Text('Teams'),
                      icon: Icon(Icons.groups),
                    ),
                  ],
                  selected: {mode},
                  onSelectionChanged: (Set<SearchMode> newSelection) {
                    setState(() {
                      mode = newSelection.first;
                      ref.read(searchQueryProvider.notifier).update('');
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: mode == SearchMode.teams
                  ? const TeamSearchWidget()
                  : const Center(
                      child: Text('Placeholder (for athlete search widget)'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
