import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/widgets/widgets.dart';
import 'package:quiz_maker/views/create_quiz.dart';

class AddQuestion extends StatefulWidget {
   final String quizId;
   AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question,option1,option2,option3,option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async{
    if(_formKey.currentState.validate()){
       setState(() {
         _isLoading = true;
       });
      Map<String,String> questionMap ={
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4
      };
      await databaseService.addQuestionData(questionMap, widget.quizId).then
        ((value){
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body:  SingleChildScrollView(
        child : Column(
          children : [
      _isLoading ?
      Container(
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
          height: 900,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Question" : null,
                decoration: InputDecoration(hintText: "Question"),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option1" : null,
                decoration: InputDecoration(hintText: "Option 1 (correct answer)"),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option 2" : null,
                decoration: InputDecoration(hintText: "Option 2"),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option 3" : null,
                decoration: InputDecoration(hintText: "Option 3"),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option 4" : null,
                decoration: InputDecoration(hintText: "Option 4"),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              //Spacer(),
              Container(
                height: 100,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: "Submit",
                      buttonWidth: MediaQuery.of(context).size.width/2 - 36
                    ),
                  ),
                  SizedBox(width: 24,),
                  GestureDetector(
                    onTap: (){
                      uploadQuestionData();
                    },
                    child: blueButton(
                        context: context,
                        label: "Add Question",
                        buttonWidth: MediaQuery.of(context).size.width/2 - 36
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              )

            ],
          ),
        ),
      ),
    ],
        ),


      ));
  }
}
