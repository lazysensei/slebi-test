import 'dart:developer';

import 'package:app/models/employee_model/employee_model.dart';
import 'package:app/models/failure/failure.dart';
import 'package:app/repository/employee_repository.dart';
import 'package:app/states/employee_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeController extends StateNotifier<EmployeeState> {
  EmployeeController(this.ref) : super(const EmployeeStateInitial());

  final Ref ref;

  getAllEmployee() async {
    state = const EmployeeStateLoading();
    Either<Failure, List<EmployeeModel>> response =
        await ref.read(employeeRepositoryProvider).getAllEmployees();

    if (response.isRight) {
      state = EmployeeStateSuccess(response.right);
    } else {
      log(response.left.text);      
      state = EmployeeStateError(response.left);
    }
  }

  resetState() {
    state = const EmployeeStateInitial();
  }
}

final employeeControllerProvider =
    StateNotifierProvider<EmployeeController, EmployeeState>((ref) {
  return EmployeeController(ref);
});
