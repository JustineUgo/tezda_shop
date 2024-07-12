// ignore_for_file: avoid_build_context_in_providers

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/models/user/user_model.dart';
import 'package:tezda_shop/src/repositories/auth_repo.dart';
import 'package:tezda_shop/src/services/image_service.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
import 'package:tezda_shop/src/services/ui_service.dart';
part 'profile_provider.g.dart';

@riverpod
class ProfileInfo extends _$ProfileInfo {
  final _repo = getIt<AuthRepo>();
  final _storage = getIt<StorageService>();
  final _imageService = getIt<EcoImageService>();
  final _ui = getIt<UIService>();
  @override
  Future<UserModel> build() async {
    UserModel user = UserModel.fromJson(await _storage.retrieve(key: StorageService.userKey));
    return user;
  }

  Future changePicture(BuildContext context, {required ImageSource source}) async {
    final previousState = await future;
    state = const AsyncLoading();
    try {
      String? image = await _imageService.pickImage(context, source: source);
      if (image != null) {
        state = AsyncData(previousState);
        updateProfile(avatar: image);
      }
    } catch (e) {
      state = AsyncData(previousState);
    }
  }

  Future updateProfile({String? name, String? avatar, String? email}) async {
    final previousState = await future;
    state = const AsyncLoading();

    try {
      final response = await _repo.updateUser(previousState.id, name: name, avatar: avatar, email: email);
      _ui.showToast(text: 'Update successful!', type: ToastType.success);
      state = AsyncData(UserModel.fromJson(response));
    } catch (_) {
      state = AsyncData(previousState);
    }
  }
}
