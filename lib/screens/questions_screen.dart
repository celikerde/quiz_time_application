import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/primary_provider.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

const List<String> list = <String>['5', '10', '20', '25'];

class _QuestionsScreenState extends State<QuestionsScreen> {
  var _showTextFormField = [];
  bool prepareQuizButton= false;
  List<TextEditingController> _controller = [];
  final titleEditingController = TextEditingController();
  @override
  void initState() {
    final myProvider = Provider.of<PrimaryProvider>(context, listen: false);
    super.initState();
  }

  void createQuestions() {
      for (int i = 0; i < 20; i++) {
        prepareQuizButton = true;
        _showTextFormField.insert(i, false);
        _controller.add(TextEditingController());
      }
  }

  void editOrCreateButtonClicked(int qIndex){
    _showTextFormField[qIndex] = true;
  }
  void saveButtonClicked(int qIndex){
    _showTextFormField[qIndex] = false;
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<PrimaryProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Center(child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("How many questions are consist of the quiz?"))),
        actions: [
          Container(
            color: Colors.white,
            child: DropdownMenu(
                hintText: "Seçiniz",
                onSelected: (String? value) {
                  setState(() {
                     myProvider.selectedQuestionNumber= int.parse(value!);
                    createQuestions();
                  });
                },
                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: prepareQuizButton,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: TextField(
                    textAlign: TextAlign.center,
                    controller: myProvider.titleEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Give a title for the quiz",
                    ),
                  ),
                  trailing: ElevatedButton(
                    child: Text("Save"),
                    onPressed: () {
                      //Provider.of<PrimaryProvider>(context,listen: false).listenTitle();
                    },
                  ),
                ),
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myProvider.selectedQuestionNumber,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Card(
                          child: ListTile(
                              title:Text('${index+1}.Question ',),
                              trailing: Wrap(
                                spacing: 8,
                                children: [
                                  ElevatedButton(onPressed: () {
                                    setState(() {
                                      editOrCreateButtonClicked(index);
                                      //_controller[index].text = selectedQuestionNumber.toString();
                                      });
                                    },
                                      child: Text("Create || Edit")),
                                  ElevatedButton(onPressed: () {
                                    setState(() {
                                      //editOrCreateButtonClicked(index);
                                      _controller[index].clear();
                                    });
                                  },
                                      child: Text("Clear")),
                                  ElevatedButton(onPressed: () {
                                    setState(() {
                                      saveButtonClicked(index);
                                    });
                                  }, child: Text("Save")),
                                ],
                              ),
                          ),
                      ),
                      Visibility(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            controller: _controller[index],
                            maxLines: null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a question',
                            ),
                          ),
                        ),
                        visible: _showTextFormField[index],
                      ),
                    ],
                  );
                },
            ),
            Visibility(
                visible: prepareQuizButton,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context,'/quizzesScreen');
                  },
                  child: Text("Prepare The Quiz!"),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
