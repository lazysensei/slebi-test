import 'package:app/models/employee_model/employee_model.dart';
import 'package:app/models/failure/failure.dart';

class EmployeeState {
  const EmployeeState();

  List<Object> get props => [];
}

class EmployeeStateInitial extends EmployeeState {
  const EmployeeStateInitial();

  @override
  List<Object> get props => [];
}

// All Employees

class EmployeeStateLoading extends EmployeeState {
  const EmployeeStateLoading();

  @override
  List<Object> get props => [];
}

class EmployeeStateSuccess extends EmployeeState {
  final List<EmployeeModel> details;
  const EmployeeStateSuccess(this.details);

  @override
  List<Object> get props => [];
}

class EmployeeStateError extends EmployeeState {
  final Failure error;
  const EmployeeStateError(this.error);

  @override
  List<Object> get props => [error];
}

// Employee Details States

class EmployeeDetailsStateInitial extends EmployeeState {
  const EmployeeDetailsStateInitial();

  @override
  List<Object> get props => [];
}

class EmployeeDetailsStateLoading extends EmployeeState {
  const EmployeeDetailsStateLoading();

  @override
  List<Object> get props => [];
}

class EmployeeDetailsStateSuccess extends EmployeeState {
  final EmployeeModel details;
  const EmployeeDetailsStateSuccess(this.details);

  @override
  List<Object> get props => [];
}

class EmployeeDetailsStateError extends EmployeeState {
  final Failure error;
  const EmployeeDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
