import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/local_entity.dart';
import '../repositories/localization_repository.dart';

class SetLocaleUseCase implements UseCase<Unit,LocaleEntity>{
  final LocalizationRepository localizationRepository ;
  SetLocaleUseCase({required this.localizationRepository});

  @override
  Future<Either<Failure, Unit>> call(LocaleEntity localeEntity)async {
    return await localizationRepository.setLocale(localeEntity);
  }
}
