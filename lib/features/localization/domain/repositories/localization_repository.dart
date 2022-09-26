import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/local_entity.dart';

abstract class LocalizationRepository {
  Either<Failure, LocaleEntity> getLocale();
  Future<Either<Failure, LocaleEntity>> setToSystemLocale();
  Future<Either<Failure, Unit>> setLocale(LocaleEntity localeEntity);
}
