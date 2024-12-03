
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/core/utils/result/result_exceptions.dart';

extension ResultExt on Result {
  int getErrorStatCode() {
    if(isError){
      try{
        var result = error as ApiResultException;
        return result.response.statCode ?? 0;
      }catch(e){
        return 0;
      }
    }
    return 0;
  }

  String getErrorMessage() {
    if(isError){
      try{
        var result = error as ApiResultException;
        return result.response.statMsg ?? result.response.message ?? '';
      }catch(e){
        return e.toString();
      }
    }
    return '';
  }

  dynamic getErrorRawData() {
    if(isError){
      try{
        var result = error as ApiResultException;
        return result.response.rawData;
      }catch(e){
        return e.toString();
      }

    }
    return '';
  }
}
