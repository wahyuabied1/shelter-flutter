import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/data/model/guard_summary_response.dart';
import 'package:shelter_super_app/data/network/guard_network.dart';

class GuardRepository {
  final GuardNetwork _guardNetwork;

  GuardRepository(this._guardNetwork);

  Future<JsonResponse<GuardSummaryResponse>> getSummary({
    required String tanggalMulai,
    required String tanggalSelesai,
  }) async {
    return _guardNetwork.getSummary(
      tanggalMulai: tanggalMulai,
      tanggalSelesai: tanggalSelesai,
    );
  }
}
