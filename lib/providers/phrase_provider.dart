import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';

// 登録された定型文
final phraseProvider = StateProvider<List<Phrase>>((ref) {
  return[];
});

// AddPhrase, 
  // アプリバーの高さ
  final appBarHeightProvider = StateProvider<double>((ref) {
    return 0.0;
  });

  // タイトルの高さ
  final titleHeightProvider = StateProvider<double>((ref) {
    return 0.0;
  });

  // 見出し「定型文」の高さ
  final phraseHeightProvider = StateProvider<double>((ref) {
    return 0.0;
  });