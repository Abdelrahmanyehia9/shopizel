import 'package:permission_handler/permission_handler.dart';

class PermissionHandlers{

   Future<bool>_checkPermission(Permission permission)async{
    PermissionStatus status = await permission.status ;

    if(status.isDenied){
       status = await permission.request() ;
       if(status.isGranted){
         return true ;
       }else{
         return false ;
       }
    }else if (status.isPermanentlyDenied)
    {
      await openAppSettings();
      status = await permission.status ;
      if (status.isGranted){
        return true ;
      }
      else{
        return false ;
      }
    }else{
      return true ;
    }
  }



  Future<bool>checkLocationPermission()async=>_checkPermission(Permission.location) ;





}