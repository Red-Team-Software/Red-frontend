class Translations {
  final String language;
  final String flag;

  Translations(this.language, this.flag);

  static List<Translations> languagesList() {
    return <Translations>[
      Translations('English', 'https://th.bing.com/th/id/R.a21162786cc0c40a5520fbc1769630f0?rik=CxVFa2ztWdqCRw&riu=http%3a%2f%2fimage.shutterstock.com%2fz%2fstock-vector-vector-background-of-half-us-and-uk-flag-175729622.jpg&ehk=1kX4%2fxUc8ycMgmF5QjHrKHwc1ipQU4K6N%2bUAio0BdJo%3d&risl=&pid=ImgRaw&r=0'),
      Translations('French', 'https://th.bing.com/th/id/OIP.mO2EfRE-TxiZgZ20kE6aOwHaE7?rs=1&pid=ImgDetMain'),
      Translations('Italian', 'https://th.bing.com/th/id/OIP.TpVkVp5HY5O7gIlMeAP8dQHaE8?rs=1&pid=ImgDetMain'),
      Translations('Español', 'https://th.bing.com/th/id/OIP.YsBdn_5ODBeaAYawGmu_8wHaE8?rs=1&pid=ImgDetMain'),
      Translations('Portuguese', 'https://media.istockphoto.com/id/483663073/es/vector/bandera-de-portugal.jpg?s=612x612&w=0&k=20&c=AhsHvnIM0tfsPcSaNdVbjsy5uCJ10gQ3mKwUqvBVuGc='),
      Translations('German', 'https://th.bing.com/th/id/OIP.-0JgOkcYn_kcem1JsgQnKwHaE8?rs=1&pid=ImgDetMain'),
      Translations('Chino', 'https://th.bing.com/th/id/OIP.VN_BoEQP-W7YtNN-LhR4OgHaE8?w=552&h=368&rs=1&pid=ImgDetMain'),

    ];
  }

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'French':
        return 'fr';
      case 'Italian':
        return 'it';
      case 'Portuguese':
        return 'pt';
      case 'Español':
        return 'es';
      case 'German':
        return 'de';
      case 'Chino':
        return 'zh-cn';
      default:
        return 'en';
    }
  }
}

