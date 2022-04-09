import 'package:copy_phrase/providers/phrase_provider.dart';
import 'package:copy_phrase/screens/add_phrase.dart';
import 'package:flutter/material.dart';
import 'package:copy_phrase/material_color/material_color.dart';
import 'package:copy_phrase/widgets/button_item.dart';
import 'package:copy_phrase/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:copy_phrase/models/phrase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _phrase = await DatabaseHelper.instance.getPhraseList();
  runApp(
    ProviderScope(
      overrides: [
        phraseProvider.overrideWithProvider(StateProvider((ref) => _phrase)),
      ],child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {

  final List<Phrase> _phraseList = ref.watch(phraseProvider.state).state;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFFD0DEEA),
        title: const Text("COPY PHRASE", style: TextStyle(color: Color(0xFF6F8AA9),)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Color(0xFF6F8AA9),
            ),
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return AddPhrase();
                })
              ),
            }
          ),
        ]
      ),
      body: Column(
        children: [
          Expanded(child:
          Container(
            width: double.maxFinite,
            // height: double.maxFinite,
            color: const Color(0xFFD0DEEA),
            child : ListView.builder(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 10.0,
                right: 10.0,
              ),
              shrinkWrap: true,
              itemCount: _phraseList.length,
              itemBuilder: (BuildContext context, int index) {
                return ButtonItem(_phraseList[index]);
              }
            )
          ),
          ),
          // Container(
          //   height: 50,
          //   color: Colors.red,
          // ),
        ],
      ),
    );
  }
}
