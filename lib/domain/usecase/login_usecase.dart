import 'package:dartz/dartz.dart';
import 'package:flutter_advanced/data/network/failure.dart';
import 'package:flutter_advanced/data/network/requests.dart';
import 'package:flutter_advanced/domain/models/models.dart';
import 'package:flutter_advanced/domain/repository/repository.dart';
import 'package:flutter_advanced/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(
      LoginRequest(
        input.email,
        input.password,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
