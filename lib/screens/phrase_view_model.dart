import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';
import 'package:copy_phrase/database/database.dart';
import 'package:copy_phrase/providers/phrase_provider.dart';

final phraseViewModelProvider = 
      StateNotifierProvider.autoDispose((ref) => PhraseViewModel(ref: ref));

class PhraseViewModel extends StateNotifier {
  var isUpdate = false;
  var id = -1;
  final titleController = TextEditingController(text: "");
  final phraseController = TextEditingController(text: "");

  final _databaseHelper = DatabaseHelper.instance;

  PhraseViewModel({required AutoDisposeStateNotifierProviderRef ref}): super(ref);

  // 更新時に実行
  init(Phrase phrase) {
    isUpdate = true;
    id = phrase.id!;
    titleController.text = phrase.title!;
    phraseController.text = phrase.phrase!;
  }

  // ボタンクリック
  Future<void> handleClick(BuildContext context, WidgetRef ref) async {
    final title = titleController.text.isNotEmpty ? titleController.text : "copy_phrase";
    final content = phraseController.text;

    final phrase = Phrase(title: title, phrase: content);
    await _savePhrase(phrase);

    // タスク一覧を再取得して代入
    ref.read(phraseProvider.state).state = await _databaseHelper.getPhraseList();

    // 一覧ページへ戻る
    Navigator.of(context).pop();
  }

  // 保存処理を行う
  Future<void> _savePhrase(Phrase phrase) async {
    if (isUpdate == false) {
      // データベースに新規メモを登録
      await _databaseHelper.insertPhrase(phrase);
    } else {
      phrase.id = id;
      // データベース上のメモを上書き
      await _databaseHelper.updatePhrase(phrase);
    }
  }

  // 削除処理
  Future<void> deletePhrase(BuildContext context,WidgetRef ref, int id) async{
    await _databaseHelper.deletePhrase(id);

    // タスク一覧を再取得して代入
    ref.read(phraseProvider.state).state = await _databaseHelper.getPhraseList();
  }
}