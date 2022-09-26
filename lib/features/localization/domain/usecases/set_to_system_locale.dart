import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/local_entity.dart';
import '../repositories/localization_repository.dart';

class SetToSystemLocaleUseCase implements UseCase<LocaleEntity, NoParams> {
  final LocalizationRepository localizationRepository;
  SetToSystemLocaleUseCase({required this.localizationRepository});

  @override
  Future<Either<Failure, LocaleEntity>> call(NoParams params) async {
    return await localizationRepository.setToSystemLocale();
  }
}
