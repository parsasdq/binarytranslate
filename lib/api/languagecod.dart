class languagecode{
  static getlanguagecode(String language){
    switch(language){
      case 'انگلیسی':
        return'en';
      case 'فارسی':
        return 'fa';
      case 'فرانسوی':
        return 'fr';
      case 'ایتالیایی':
        return 'it';
      case 'روسی':
        return 'ru';
      case 'اسپانیایی':
        return 'es';
      case 'المانی':
        return 'de';
      default:
        return 'en';
    }
  }
//   static final Map LanguageMap ={
//     'انگلیسی': 'English',
//     'فارسی' : 'Persian',
//     'فرانسوی' : 'French',
//     'المانی' : 'German',
//     'اسپانیایی': 'Spanish',
//     'ایتالیایی': 'Italian',
//     'روسی' : 'Russian',
//   };
}