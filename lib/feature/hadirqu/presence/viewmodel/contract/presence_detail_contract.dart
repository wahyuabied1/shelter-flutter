import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/hadirqu_presence_detail_response.dart';

abstract class PresenceDetailContract {
  Future<bool> getPresenceDetail(int idKaryawan);

  Result<HadirquPresenceDetailResponse?> get presenceDetailResult;
}
