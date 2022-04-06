import 'package:copy_phrase/screens/phrase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';

class EditPhrase extends ConsumerWidget {
  final _key = GlobalKey<FormState>();
  Phrase? phrase;

  EditPhrase({this.phrase, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(phraseViewModelProvider.notifier);
    if (phrase != null && phrase?.id !=null) {
      viewModel.init(phrase!);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFFD0DEEA),
        iconTheme: const IconThemeData(color: Color(0xFF6F8AA9)),
        title: const Text("定型文編集", style: TextStyle(color: Color(0xFF6F8AA9),)),
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
      body: Container(
        child: Form(
          key: _key,
          child: Container(
            color: const Color(0xFFD0DEEA),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
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
                Expanded(child:
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(left: 3, bottom: 3),
                        child: const Text("定型文",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF6F8AA9),
                          ),
                        ),
                      ),
                      Expanded(child: 
                      TextFormField(
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
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 30,
                  width: 100.0,
                  child: TextButton(
                    onPressed: () async{
                      var result = await showDialog<int>(
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
                                        onPressed: () => Navigator.of(context).pop(0),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: const Color(0xFFE61639),
                                        ),
                                        onPressed: () => Navigator.of(context).pop(1),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                            ],
                          );
                        },
                      );

                      if (result == 1) {
                        viewModel.deletePhrase(context, ref, phrase!.id!);
                        Navigator.of(context).pop();
                      }
                    }, 
                    style: TextButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      backgroundColor: Color(0xFFE61639),
                    ),
                    child: const Text(
                      "削除",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}