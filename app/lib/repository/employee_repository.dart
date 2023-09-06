import 'package:app/services/employee_services.dart';
import 'package:app/models/employee_model/employee_model.dart';
import 'package:app/models/failure/failure.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeRepository {
  final EmployeeServices _employeeServices;
  EmployeeRepository(this._employeeServices);

  Future<Either<Failure, List<EmployeeModel>>> getAllEmployees() async {
    Either<Failure, List<EmployeeModel>> response =
        await _employeeServices.getAllEmployees();
    if (response.isRight) {
      return Right(response.right);
    } else {
      return Left(response.left);
    }
  }
}

final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  return EmployeeRepository(ref.read(employeeServiceProvider));
});
