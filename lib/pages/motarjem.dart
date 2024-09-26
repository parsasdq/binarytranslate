import 'package:binarytranslate/api/language.dart';
import 'package:binarytranslate/api/languagecod.dart';
import 'package:binarytranslate/api/translation_api.dart';
import 'package:binarytranslate/controller/icon_controller.dart';
import 'package:binarytranslate/controller/language_controller.dart';
import 'package:binarytranslate/controller/result_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:binarytranslate/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';

String lan1 = 'en';
String lan2 = 'fa';
String namayesh = '';
FlutterTts tTos = FlutterTts();
SpeechToText sTot = SpeechToText();
bool islistening = false;
String speaktxt = '';
var matn;
ResultController resultController = Get.put(ResultController());
LanguageController languageController = Get.put(LanguageController());
IconController iconController = Get.put(IconController());
TextEditingController matncontroller = TextEditingController();

class motarjem extends StatelessWidget {
  const motarjem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 20,
            margin: const EdgeInsets.all(10),
            child: Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'زبان مبدا',
                        style: tabe_style,
                      ),
                      Text(
                        'زبان مقصد',
                        style: tabe_style,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width / 2) - 80,
                            height: 50,
                            margin: EdgeInsets.all(20),
                            child: Obx(
                              () => DropdownButtonFormField<String>(
                                items: language
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        child: Text(
                                          item,
                                          style: tabe_style,
                                        ),
                                        value: item,
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                      ),
                                    )
                                    .toList(),
                                onChanged: (item) {
                                  languageController.SourceLanguage.value =
                                      item!;
                                  lan1 = languagecode.getlanguagecode(item);
                                  print(lan1);
                                },
                                value: languageController.SourceLanguage.value,
                                style: tabe_style,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.white),
                                  ),
                                  fillColor: Colors.grey[200],
                                ),
                              ),
                            ),
                          )),
                      InkWell(
                        child: Icon(
                          Icons.swipe_rounded,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          var deslocal =
                              languageController.DestinationLanguage.value;
                          languageController.DestinationLanguage.value =
                              languageController.SourceLanguage.value;
                          languageController.SourceLanguage.value = deslocal;
                        },
                      ),
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                              color: Colors.white,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 80,
                              height: 50,
                              margin: EdgeInsets.all(20),
                              child: Obx(
                                () => DropdownButtonFormField<String>(
                                  items: language
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          child: Text(
                                            item,
                                            style: tabe_style,
                                          ),
                                          value: item,
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (item) {
                                    languageController
                                        .DestinationLanguage.value = item!;
                                    lan2 = languagecode.getlanguagecode(item);
                                    print(lan2);
                                  },
                                  value: languageController
                                      .DestinationLanguage.value,
                                  style: tabe_style,
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.white),
                                    ),
                                    fillColor: Colors.grey[200],
                                  ),
                                ),
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 140,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 20,
                      ),
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
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  matncontroller.text = '';
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.volume_up,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  String sp_lan = lan1;
                                  tTos.setLanguage(sp_lan);
                                  tTos.speak(matncontroller.text);
                                },
                              ),
                            ],
                          ),
                        ),
                        controller: matncontroller,
                        onChanged: (text) {
                          matn = text;
                          translate_func();
                        },
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      translate_func();
                      print(ResultController().result.value);
                    },
                    height: 60,
                    minWidth: 300,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'ترجمه کن',
                      style: button_style,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 150,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.volume_up_rounded,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  tTos.setLanguage(lan2);
                                  tTos.speak(resultController.result.value);
                                },
                              ),
                              Obx(
                                () => Text(
                                  resultController.result.value,
                                  style: tabe_style,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ]))),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: AvatarGlow(
          animate: islistening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 40,
          duration: Duration(microseconds: 2500),
          repeatPauseDuration: Duration(microseconds: 150),
          repeat: true,
          child: Obx(
            () => FloatingActionButton(
                onPressed: () {
                  listen();
                  if (islistening) {
                    sTot.stop();
                    iconController.icon.value = Icons.mic_off;
                  }
                },
                shape: CircleBorder(),
                child: Icon(
                  iconController.icon.value,
                )),
          ),
        ),
      ),
    );
  }
}

Future translate_func() async {
  var value = await TranslationApi().translate(matn, lan1, lan2);
  resultController.result.value = value;
}

void listen() async {
  if (!islistening) {
    bool available = await sTot.initialize();
    if (available) {
      islistening = true;
      sTot.listen(onResult: (value) {
        speaktxt = value.recognizedWords;
        matncontroller.text = speaktxt;
        matn = speaktxt;
        translate_func();
        iconController.icon.value = Icons.keyboard_voice;
      });
    } else {
      () async {
        islistening = false;
        await sTot.stop();
        SnackBar(content: Text('خطا در استفاده از میکروفون'));
      };
    }
  } else {
    () async {
      islistening = false;
      await sTot.stop();
    };
  }
}
