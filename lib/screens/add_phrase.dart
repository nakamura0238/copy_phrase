import 'package:copy_phrase/screens/phrase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPhrase extends ConsumerWidget {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(phraseViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
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
              ],
            ),
          ),
        ),
      )
    );
  }
}