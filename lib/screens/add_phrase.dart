import 'package:copy_phrase/screens/phrase_view_model.dart';
import 'package:copy_phrase/providers/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPhrase extends ConsumerStatefulWidget {
  const AddPhrase({Key? key}) : super(key: key);

  @override
  _AddPhrase createState() => _AddPhrase();
}

class _AddPhrase extends ConsumerState<AddPhrase> {
  final _key = GlobalKey<FormState>();
  final _appBarKey = GlobalKey();
  final _titleKey = GlobalKey();
  final _phraseKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref.read(appBarHeightProvider.notifier).state = _appBarKey.currentContext!.size!.height;
      ref.read(titleHeightProvider.notifier).state = _titleKey.currentContext!.size!.height;
      ref.read(phraseHeightProvider.notifier).state = _phraseKey.currentContext!.size!.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(phraseViewModelProvider.notifier);
    final size = MediaQuery.of(context).size.height;

    final appBarHeight = ref.watch(appBarHeightProvider);
    final titleHeight = ref.watch(titleHeightProvider);
    final phraseHeight = ref.watch(phraseHeightProvider);
    
    return Scaffold(
      appBar: AppBar(
        key: _appBarKey,
        elevation: 1,
        backgroundColor: const Color(0xFFD0DEEA),
        iconTheme: const IconThemeData(color: Color(0xFF6F8AA9)),
        title: const Text("定型文追加", style: TextStyle(color: Color(0xFF6F8AA9),)),
        actions: <Widget>[
          TextButton(
            child: const Text("保存", 
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6F8AA9)
              ),
            ),
            onPressed: () {
              viewModel.handleClick(context, ref);
            }
          ),
        ],
      ),
      body: 
      SingleChildScrollView(
        child: Container(
            color: const Color(0xFFD0DEEA),
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  key: _titleKey,
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(left: 3, bottom: 3),
                        child: const Text("タイトル",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF6F8AA9),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: viewModel.titleController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6F8AA9))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6F8AA9))
                          ),
                        ),
                      ),
                    ],
                  ), 
                ),
                Container(
                  key: _phraseKey,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 3, top: 10, bottom: 3),
                  child: const Text("定型文",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF6F8AA9),
                    ),
                  ),
                ),
                SizedBox(
                  height:  size - (appBarHeight + titleHeight + phraseHeight + 30.0),
                  child: TextFormField(
                    expands: true,
                    controller: viewModel.phraseController,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6F8AA9))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF6F8AA9))
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ), 
          ),
        ),
      ),
      ),
    );
  }
}