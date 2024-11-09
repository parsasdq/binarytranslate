import 'package:flutter/material.dart';
import 'package:binarytranslate/api/translation_api.dart';
import 'package:binarytranslate/style/style.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
class tashkhis extends StatefulWidget {
  const tashkhis({super.key});

  @override
  State<tashkhis> createState() => _tashkhisState();
}

class _tashkhisState extends State<tashkhis> {
  bool isscanning=false;
  String scannedtext='';
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
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width-50,
                height: MediaQuery.of(context).size.height*1/3,
                child:image==null? Image.asset("scanning.gif"):Text("scanned text: ${scannedtext}",maxLines: 9,)),
                SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 160,
                    child: FloatingActionButton(onPressed: (){
                  
                    },
                     backgroundColor:Colors.blue ,
                    child: Text("pick image"),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 160,
                    child: FloatingActionButton(onPressed: (){
                    
                    },
                    backgroundColor:Colors.blue ,
                    child: Text("take image"),),
                  ),
                ],
              ),
            ],
          ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: FloatingActionButton(onPressed: (){},shape: CircleBorder(),child: Icon(Icons.keyboard_voice,),),
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
      scannedtext='Error';

    }
  }
  void GetTextFromImage(XFile image)async{
    word.clear();
    scannedtext='';
    final inputImage = InputImage.fromFilePath(image.path);
    final textsearch = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textsearch.processImage(inputImage);
    await textsearch.close();
    for(TextBlock block in recognisedText.blocks){
      for(TextLine Line in block.lines){
        word.addAll({Line.text.toString(): 'none'});
        scannedtext =scannedtext +Line.text +'\n';
      }
    }
    print(word);
    isscanning =false;
    setState(() {
    });
  }
  void Translate_function()async{
    istranslating=true;
    for(var word in word.keys){
      final wordtranslated =await TranslationApi().translate(word,'en','fa');
      word.update(word, (value) => wordtranslated);
    }
    for(var val in word.values){
      translatedtxt =translatedtxt+val+'\n';
    }
    print(word);
    istranslating=false;
    setState(() {});
  }
}