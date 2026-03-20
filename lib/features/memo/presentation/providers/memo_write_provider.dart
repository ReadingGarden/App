import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repositories/memo_repository.dart';
import '../../domain/entities/memo_write_input_entity.dart';

final okButtonProvider = StateProvider<bool>((ref) => false);
final memoImageFileProvider = StateProvider<XFile?>((ref) => null);
final memoImageNameProvider = StateProvider<String?>((ref) => null);
final memoImageUpdateProvider = StateProvider<bool>((ref) => true);

Future<void> initializeMemoWrite(
  WidgetRef ref,
  MemoWriteInputEntity input,
) async {
  ref.read(okButtonProvider.notifier).state = input.memoContent.isNotEmpty;
  ref.read(memoImageFileProvider.notifier).state = null;
  ref.read(memoImageNameProvider.notifier).state = input.imageUrl;
  ref.read(memoImageUpdateProvider.notifier).state = !input.isEdit;
}

void updateMemoTextState(WidgetRef ref, String value) {
  ref.read(okButtonProvider.notifier).state = value.isNotEmpty;
}

void setMemoImage(WidgetRef ref, XFile? image) {
  ref.read(memoImageFileProvider.notifier).state = image;
  ref.read(memoImageNameProvider.notifier).state = image?.name;
}

void clearMemoImage(WidgetRef ref) {
  ref.read(memoImageFileProvider.notifier).state = null;
  ref.read(memoImageNameProvider.notifier).state = null;
  ref.read(memoImageUpdateProvider.notifier).state = true;
}

Future<bool> saveMemo(
  WidgetRef ref,
  MemoWriteInputEntity input,
  String content,
) async {
  final repository = ref.read(memoRepositoryProvider);
  final imageFile = ref.read(memoImageFileProvider);
  final imageName = ref.read(memoImageNameProvider);
  final removedExistingImage = ref.read(memoImageUpdateProvider);

  if (!input.isEdit) {
    final memoId = await repository.createMemo(input.toRequestMap(content));
    if (memoId == null) {
      return false;
    }

    if (imageFile != null) {
      return repository.uploadMemoImage(memoId, imageFile.path);
    }
    return true;
  }

  final updated = await repository.updateMemo(
    input.id!,
    input.toRequestMap(content),
  );
  if (!updated) {
    return false;
  }

  if (input.imageUrl != null) {
    if (imageName != null) {
      if (imageName != input.imageUrl && imageFile != null) {
        return repository.uploadMemoImage(input.id!, imageFile.path);
      }
      return true;
    }

    if (removedExistingImage) {
      return repository.deleteMemoImage(input.id!);
    }

    return true;
  }

  if (imageFile != null) {
    return repository.uploadMemoImage(input.id!, imageFile.path);
  }

  return true;
}
