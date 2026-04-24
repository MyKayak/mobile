import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Impostazioni")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Indirizzo IP dell'API", style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                TextField(
                  controller: TextEditingController(text: settings.serverIp),
                  decoration: const InputDecoration(
                    hintText: 'Inserisci l\'indirizzo IP',
                  ),
                  onSubmitted: (value) {
                    ref.read(settingsStateProvider.notifier).updateServerIp(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
