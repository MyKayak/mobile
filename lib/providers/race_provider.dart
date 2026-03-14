import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/requests.dart';
import '../models/race.dart';

part 'race_provider.g.dart';

@riverpod 
Future<List<Race>> races(Ref ref, String meetId) async {
  return await getRaces(meetId);
}