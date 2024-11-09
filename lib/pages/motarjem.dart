import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
// import 'package:text_to_speech/text_to_speech.dart';
import 'package:binarytranslate/api/languagecod.dart';
import 'package:binarytranslate/api/translation_api.dart';
import 'package:binarytranslate/style/style.dart';

class motarjem extends StatefulWidget {
  const motarjem({super.key});

  @override
  State<motarjem> createState() => _motarjemState();
}
List<String> srclanguage =[
  'انگلیسی',
  'فارسی',
  'فرانسوی',
  'المانی',
  'اسپانیایی',
  'ایتالیایی',
  'روسی',
];List<String> deslanguage =[
  'فارسی',
  'انگلیسی',
  'فرانسوی',
  'المانی',
  'اسپانیایی',
  'ایتالیایی',
  'روسی',
];
String SelectedSCRLanguage ='انگلیسی';
String SelectedDESLanguage ='فارسی';
String lan1 ='en';
String lan2 ='fa';
String matn = '';
String namayesh ='محل نمایش نتایج';
var result;
FlutterTts tTos = FlutterTts();
SpeechToText sTot = SpeechToText();
bool islistening =false;
String speaktxt='';
TextEditingController matncontroller =TextEditingController();
class _motarjemState extends State<motarjem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 20,
          margin: EdgeInsets.all(10),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
                children: [
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('زبان مبدا',style: tabe_style,),
                      Text('زبان مقصد',style: tabe_style,)
                    ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width/2) -80,
                            height: 50,
                            margin: EdgeInsets.all(20),
                            child: DropdownButtonFormField<String>(items: srclanguage.map((item) => DropdownMenuItem<String>(
                              child: Text(item,style: tabe_style,),
                              value: item,
                              alignment: AlignmentDirectional.centerEnd,),).toList(),
                              onChanged: (item)=> setState(() {
                                SelectedSCRLanguage =item!;
                                lan1 = languagecode.getlanguagecode(item);
                                print(lan1);
                              }),
                              value: SelectedSCRLanguage,
                              style: tabe_style,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 2,color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 2,color: Colors.white),
                                ),
                                fillColor: Colors.grey[200],
                              ),),
                          )),  Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width/2) -80,
                            height: 50,
                            margin: EdgeInsets.all(20),
                            child: DropdownButtonFormField<String>(items: deslanguage.map((item) => DropdownMenuItem<String>(
                              child: Text(item,style: tabe_style,),
                              value: item,
                              alignment: AlignmentDirectional.centerEnd,),).toList(),
                              onChanged: (item)=> setState(() {
                                SelectedDESLanguage =item!;
                                lan2 = languagecode.getlanguagecode(item);
                                print(lan2);
                              }),
                              value: SelectedDESLanguage,
                              style: tabe_style,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 2,color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 2,color: Colors.white),
                                ),
                                fillColor: Colors.grey[200],
                              ),),
                          ))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(height: 140,width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20,right: 20,left: 20,),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        autofocus: false,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelStyle: tabe_style,
                          hintText: 'متن خود را وارد نمایید'
                              '\ntype your text here',
                          hintStyle: tabe_style,
                          icon: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(child: Icon(Icons.clear,color: Colors.red,),onTap: (){
                                matncontroller.text='';
                              },),
                              SizedBox(height: 15,),
                              InkWell(child: Icon(Icons.volume_up,color: Colors.blue,),onTap: (){
                                String sp_lan = lan1;
                                tTos.setLanguage(sp_lan);
                                tTos.speak(matncontroller.text);
                              },),
                            ],),
                        ),
                        controller: matncontroller,
                        onChanged: (text){
                          translate_func();
                          setState(() {
                            matn =text;
                            namayesh=result;
                          });
                        },
                      ),
                    ),),
                  MaterialButton(
                    onPressed: (){
                      translate_func();
                      setState(() {
                        namayesh=result;
                      });
                    },
                    height: 60,
                    minWidth: 300,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Text('ترجمه کن',style: button_style,),

                  ),
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width-100,
                        height: 150,
                        child: Center(child:Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(child: Icon(Icons.volume_up_rounded,color: Colors.blue,),onTap: (){
                              tTos.setLanguage(lan2);
                              tTos.speak(namayesh);
                            },),
                            Text(namayesh,style: tabe_style,),
                          ],
                        ),),
                      )],)
                ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: AvatarGlow(
          animate: islistening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 40,
          duration: Duration(microseconds: 2500),
          repeatPauseDuration: Duration(microseconds: 150),
          repeat: true,
          child: FloatingActionButton(onPressed: (){
            listen();
          },shape: CircleBorder(),child: Icon(islistening ?Icons.keyboard_voice:Icons.mic_off,),),
        ),
      ),);
  }
  Future translate_func() async {
    result =  await TranslationApi().translate(matn, lan1, lan2);
    print(result);
    setState() {
      namayesh =result;
    }}
  void listen()async{
    if(!islistening){
      bool available = await sTot.initialize();
      if(available){
        setState(() {
          islistening=true;
        });
        sTot.listen(
            onResult: (value){
              setState(() {
                speaktxt= value.recognizedWords;
                matncontroller.text =speaktxt;
                matn=speaktxt;
              });
            }
        );
      }else{setState(() async {
        islistening=false;
        await sTot.stop();
        SnackBar(content: Text('خطا در استفاده از میکروفون'));
      });}
    }else{setState(() async {
      islistening=false;
      await sTot.stop();
    });}
  }
}