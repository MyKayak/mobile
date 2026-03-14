import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/requests.dart';
import '../models/meet.dart';

part 'meet_provider.g.dart';

@riverpod 
Future<List<Meet>> meets(Ref ref) async {
  return await getMeets();
}