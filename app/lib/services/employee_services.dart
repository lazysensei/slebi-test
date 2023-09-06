import 'dart:developer';
import 'package:app/models/employee_model/employee_model.dart';
import 'package:app/models/failure/failure.dart';
import 'package:app/networklayer/connectivity.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeServices {
  Future<Either<Failure, List<EmployeeModel>>> getAllEmployees() async {
    bool checked = await InternetConnectionChecker.checkInternetConnectivity();

    if (!checked) {
      return Left(Failure(
          "Connection can't be reached kindly check your internet connection",
          200));
    }

    try {
      http.Response response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
      );
      if (response.statusCode != 200) {
        var json = jsonDecode(response.body);
        return Left(
          Failure(
            json['text'],
            response.statusCode,
          ),
        );
      }
      final List<EmployeeModel> employees = [];
      final objectArray = jsonDecode(response.body);
      for (var element in objectArray) {
        employees.add(EmployeeModel.fromJson(element));
      }
      return Right(employees);
    } catch (e) {
      return Left(Failure(e.toString(), 200));
    }
  }
}

final employeeServiceProvider =
    Provider<EmployeeServices>((ref) => EmployeeServices());
