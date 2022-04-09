import 'package:copy_phrase/screens/phrase_view_model.dart';
import 'package:copy_phrase/providers/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';

class EditPhrase extends ConsumerStatefulWidget {
  final Phrase? phrase;

  EditPhrase({required Phrase this.phrase, Key? key}) : super(key: key);

  @override
  _EditPhrase createState() => _EditPhrase();
}

class _EditPhrase extends ConsumerState<EditPhrase> {
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
    if (widget.phrase != null && widget.phrase?.id !=null) {
      viewModel.init(widget.phrase!);
    }

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
        title: const Text("定型文編集", style: TextStyle(color: Color(0xFF6F8AA9),)),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              var result = await deleteDialog(context);

              if (result!) {
                viewModel.deletePhrase(context, ref, widget.phrase!.id!);
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.delete),
          ),
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
                // const SizedBox(height: 10.0),
                // SizedBox(
                //   height: 30,
                //   width: 100.0,
                //   child: TextButton(
                //     onPressed: () async{
                //       var result = await deleteDialog(context);

                //       if (result!) {
                //         viewModel.deletePhrase(context, ref, widget.phrase!.id!);
                //         Navigator.of(context).pop();
                //       }
                //     }, 
                //     style: TextButton.styleFrom(
                //       elevation: 0,
                //       padding: const EdgeInsets.all(0),
                //       backgroundColor: const Color(0xFFE61639),
                //     ),
                //     child: const Text(
                //       "削除",
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

Future<bool?> deleteDialog(BuildContext context) async {
  var result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: <Widget>[
          Column(
            children: [
              const Text(
                "定型文を削除します",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: const Color(0xFFE61639),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ]
          ),
        ],
      );
    }
  );
  return result;
}