import '../../../../../core/database/remote/firebase_constant.dart';

class GenerateImg {
  static String getImg(String cat) {
    switch (cat) {
      case  FirebaseConstant.tShirt:
        return "https://i.postimg.cc/0jv2pr9f/pngwing-com-12.png";
      case FirebaseConstant.classic:
        return "https://i.postimg.cc/mZ37KH1T/pngwing-com-17.png";
      case FirebaseConstant.pants:
        return "https://i.postimg.cc/Ls4Gqbnh/pngwing-com-26.png";
      case FirebaseConstant.dress:
        return "https://i.postimg.cc/VvxKDS7J/pngwing-com-23.png";
      case FirebaseConstant.babyClothes:
        return "https://i.postimg.cc/NMkwvDw6/pngwing-com-15.png";
      case FirebaseConstant.shirt:
        return "https://i.postimg.cc/d0YzJfjh/pngwing-com-21.png"  ;
      case FirebaseConstant.skirt:
        return "https://i.postimg.cc/tTSSVq8M/pngwing-com-24.png";
      case FirebaseConstant.blazer:
        return "https://i.postimg.cc/mZ0xdj66/pngwing-com-25.png" ;
      case FirebaseConstant.shoes:
        return "https://i.postimg.cc/SxgDPNxN/pngwing-com-28.png";
      case FirebaseConstant.girlKidsClothes:
        return "https://i.postimg.cc/nhfJL24Q/pngwing-com-29.png";
      case FirebaseConstant.boyKidsClothes:
        return "https://i.postimg.cc/xC5Cv7P7/pngwing-com-30.png";
      case FirebaseConstant.top:
        return "https://i.postimg.cc/9WVBd91P/pngwing-com-31.png";
      default:
        return "https://i.postimg.cc/c4HGPfk3/pngwing-com-16.png" ;
    }
  }
}
