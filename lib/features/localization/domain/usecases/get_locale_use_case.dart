import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/local_entity.dart';
import '../repositories/localization_repository.dart';

class GetLocaleUseCase {
  final LocalizationRepository localizationRepository;
  GetLocaleUseCase({required this.localizationRepository});

  Either<Failure, LocaleEntity> call() {
    return localizationRepository.getLocale();
  }
}
