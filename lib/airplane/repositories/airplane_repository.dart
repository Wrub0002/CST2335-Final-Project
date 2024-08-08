import '../models/airplane_entity.dart';
import 'airplane_dao.dart';

class AirplaneRepository {
  final AirplaneDao airplaneDao;

  AirplaneRepository(this.airplaneDao);

  Future<List<AirplaneEntity>> getAllAirplanes() {
    return airplaneDao.findAllAirplanes();
  }

  Future<AirplaneEntity?> getAirplaneById(int id) {
    return airplaneDao.findAirplaneById(id);
  }

  Future<void> insertAirplane(AirplaneEntity airplane) {
    return airplaneDao.insertAirplane(airplane);
  }

  Future<void> updateAirplane(AirplaneEntity airplane) {
    return airplaneDao.updateAirplane(airplane);
  }

  Future<void> deleteAirplane(AirplaneEntity airplane) {
    return airplaneDao.deleteAirplane(airplane);
  }
}
