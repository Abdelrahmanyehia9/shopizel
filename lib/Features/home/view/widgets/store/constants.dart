import '../../../../../core/database/firebase_constant.dart';

class GenerateImg {
  static String getImg(String cat) {
    switch (cat) {
      case  FirebaseConstant.tShirt:
        return "https://i.postimg.cc/0jv2pr9f/pngwing-com-12.png";
      case FirebaseConstant.classic:
        return "https://i.postimg.cc/mZ37KH1T/pngwing-com-17.png";
      case FirebaseConstant.pants:
        return "https://i.postimg.cc/VNbYpX6g/pngwing-com-13.png";
      case FirebaseConstant.dress:
        return "https://i.postimg.cc/VvxKDS7J/pngwing-com-23.png";
      case FirebaseConstant.babyClothes:
        return "https://i.postimg.cc/NMkwvDw6/pngwing-com-15.png";
      case FirebaseConstant.shirt:
        return "https://i.postimg.cc/d0YzJfjh/pngwing-com-21.png"  ;
      default:
        return "https://i.postimg.cc/c4HGPfk3/pngwing-com-16.png" ;
    }
  }
}
