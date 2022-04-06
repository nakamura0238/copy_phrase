import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';

final phraseProvider = StateProvider<List<Phrase>>((ref) {
  return[];
});