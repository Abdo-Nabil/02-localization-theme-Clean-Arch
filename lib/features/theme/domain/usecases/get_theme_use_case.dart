import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository themeRepository;
  const GetThemeUseCase({required this.themeRepository});

  Either<Failure, ThemeEntity> call() {
    return themeRepository.getTheme();
  }
}
