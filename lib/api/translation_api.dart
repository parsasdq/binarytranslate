import 'package:translator/translator.dart';
class TranslationApi{
  Future translate(String msg, String fromLanguagecode,toLanguagecode)async{
    final translation = await GoogleTranslator().translate(msg,from: fromLanguagecode,to: toLanguagecode);
    return translation.text;
  }
}