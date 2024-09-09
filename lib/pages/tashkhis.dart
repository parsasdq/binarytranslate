import 'package:flutter/material.dart';
import 'package:binarytranslate/api/translation_api.dart';
import 'package:binarytranslate/style/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
class tashkhis extends StatefulWidget {
  const tashkhis({super.key});

  @override
  State<tashkhis> createState() => _tashkhisState();
}

class _tashkhisState extends State<tashkhis> {
  bool isscanning=false;
  String sctext='';
  XFile? image;
  Map word={};
  bool istranslating=false;
  String translatedtxt='';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 20,
          margin: EdgeInsets.all(10),
          child: Center(child: Text('.....تشخیص متن به زودی ',style: style.title_style )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(onPressed: (){},shape: CircleBorder(),child: Icon(Icons.keyboard_voice,),),
      ),);
  }
  void GetImage(ImageSource imageSource)async{
    try{
      final pickedim= await ImagePicker().pickImage(source: imageSource);
      if(pickedim!=null){
        setState(() {
          isscanning=true;
          image =pickedim;
        });
        GetTextFromImage(pickedim);
      }
    }
    catch(e){
      isscanning=false;
      image=null;
      sctext='Error';

    }
  }
  void GetTextFromImage(XFile image)async{
    word.clear();
    sctext='';
    final inputImage = InputImage.fromFilePath(image.path);
    final textsearch = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textsearch.processImage(inputImage);
    await textsearch.close();
    for(TextBlock block in recognisedText.blocks){
      for(TextLine Line in block.lines){
        word.addAll({Line.text.toString(): 'none'});
        sctext =sctext +Line.text +'\n';
      }
    }
    print(word);
    isscanning =false;
    setState(() {
    });
  }
  void Translate_function()async{
    istranslating=true;
    for(var key in word.keys){
      final wordtranslated =await TranslationApi().translate(key,'en','fa');
      word.update(key, (value) => wordtranslated);
    }
    for(var val in word.values){
      translatedtxt =translatedtxt+val+'\n';
    }
    print(word);
    istranslating=false;
    setState(() {});
  }
}