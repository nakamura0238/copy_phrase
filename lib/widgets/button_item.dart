import 'package:copy_phrase/screens/edit_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';
import 'package:flutter/services.dart';


class ButtonItem extends ConsumerWidget {

  final Phrase _phrase;
  ButtonItem(this._phrase, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF96B4CE)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 8,
            child: TextButton(
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: _phrase.phrase));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(4),
                      topRight:Radius.circular(0),
                      bottomLeft:Radius.circular(4),
                      bottomRight:Radius.circular(0),
                    )
                ),
              ),
              // child: const Text('Button'),
              child: ListTile(
                title: Text(_phrase.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(_phrase.phrase!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ),
          ),
          Expanded(
            child:
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return EditPhrase(phrase: _phrase);
                    }));
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF96B4CE),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: const Size(30, 72), //最小のサイズ
                  padding: const EdgeInsets.all(4),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(0),
                      topRight:Radius.circular(4),
                      bottomLeft:Radius.circular(0),
                      bottomRight:Radius.circular(4),
                    )
                  )
                ),
                child: const Icon(Icons.edit, color: Colors.white,),
              ),
            ),
        ],
      )
    );
  }
}