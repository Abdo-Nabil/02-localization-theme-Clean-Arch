import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/theme_entity.dart';

abstract class ThemeRepository {
  Either<Failure, ThemeEntity> getTheme();
  Future<Either<Failure, Unit>> setTheme(ThemeEntity themeEntity);
}
