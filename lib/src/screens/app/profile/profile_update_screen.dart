import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/src/screens/app/profile/provider/profile_provider.dart';
import 'package:tezda_shop/src/services/ui_service.dart';
import 'package:tezda_shop/src/shared/image_widget.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';
import 'package:tezda_shop/util/helpers.dart';

@RoutePage()
class ProfileUpdateScreen extends ConsumerStatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends ConsumerState<ProfileUpdateScreen> {
  Future<void> showPicker(context) async {
    return await getIt<UIService>().showEcoBottomSheet(
      context,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              ref.read(profileInfoProvider.notifier).changePicture(context, source: ImageSource.camera);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Sizes.baseDouble),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Camera', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(profileInfoProvider.notifier).changePicture(context, source: ImageSource.gallery);
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Sizes.baseDouble),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gallery', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
            ),
          ),
          const SizedBox(height: Sizes.baseDoubleHalf),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TezdaColors.light,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const SizedBox(height: Sizes.baseSingle),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.router.back(),
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.baseDouble),
                      color: TezdaColors.grey,
                      child: const Center(child: Icon(CupertinoIcons.chevron_back, color: TezdaColors.dark)),
                    ),
                  ),
                  Text('Personal Information', style: context.textTheme.headlineLarge),
                  Opacity(
                    opacity: 0,
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.baseDouble),
                      child: const Center(child: Icon(CupertinoIcons.arrow_left)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: Sizes.baseDouble),
              Expanded(
                child: UpdateForm(onTapImage: () => showPicker(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateForm extends ConsumerStatefulWidget {
  const UpdateForm({super.key, required this.onTapImage});
  final Function() onTapImage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateFormState();
}

class _UpdateFormState extends ConsumerState<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileInfoAsync = ref.watch(profileInfoProvider);
    return Column(
      children: [
        Expanded(
          child: profileInfoAsync.when(
              error: (_, __) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.invalidate(profileInfoProvider);
                            ref.read(profileInfoProvider);
                          },
                          child: const Text('Retry'),
                        ),
                      ),
                    ],
                  ),
              data: (user) {
                // _emailController.text = user.email;
                // _nameController.text = user.name;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.baseDouble),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: widget.onTapImage,
                          child: SizedBox.square(
                            dimension: 150,
                            child: TezdaImage(image: user.avatar, radius: 30, width: 100, height: 100),
                          ),
                        ),
                        InkWell(
                          onTap: widget.onTapImage,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.baseSingle),
                            child: Text('Change', style: context.textTheme.bodyLarge!.copyWith(color: TezdaColors.primary)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(hintText: 'Name'),
                                textCapitalization: TextCapitalization.words,
                                // validator: (value) => Helpers.fieldValidator(context, value),
                              ),
                              const SizedBox(height: Sizes.baseDouble),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(hintText: 'Email'),
                                textCapitalization: TextCapitalization.words,
                                validator: (value) => Helpers.emailValidator(context, value),
                              ),
                              const SizedBox(height: Sizes.baseDouble),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
        Padding(
          padding: const EdgeInsets.all(Sizes.baseDouble),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                getIt<UIService>().showConfirmationDialog(
                  context,
                  icon: TezdaIcons.personalInfoIcon,
                  title: 'Update profile?',
                  body: 'Are you sure you want to update your profile?',
                  status: DialogStatus.success,
                  confirmText: 'Ok',
                  onConfirm: () => ref.read(profileInfoProvider.notifier).updateProfile(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                      ),
                  cancelText: 'No, cancel',
                  onCancel: () {},
                );
              }
            },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
