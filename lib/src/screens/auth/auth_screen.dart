import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_shop/routes/router.gr.dart';
import 'package:tezda_shop/src/screens/auth/provider/auth_provider.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';
import 'package:tezda_shop/util/helpers.dart';

@RoutePage()
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final PageController _pageController = PageController();
  double heightMultiplier = .9;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page == 1) {
        setState(() => heightMultiplier = .6);
      } else {
        setState(() => heightMultiplier = .9);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: TezdaColors.light,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * heightMultiplier,
                decoration: BoxDecoration(
                  color: TezdaColors.light,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                margin: const EdgeInsets.all(20),
                child: PageView(
                  controller: _pageController,
                  children: [
                    RegForm(
                      formKey: _formKey,
                      nameController: _nameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      onSuccess: () => _pageController.jumpToPage(1),
                    ),
                    LoginForm(
                      formKey: _loginFormKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      onSuccess: () {
                        _pageController.jumpToPage(0);
                        context.router.replaceAll([const HomeRoute()]);
                      },
                      onBack: () {
                        _pageController.jumpToPage(0);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegForm extends ConsumerWidget {
  const RegForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController nameController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required this.onSuccess,
  })  : _formKey = formKey,
        _emailController = emailController,
        _nameController = nameController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _nameController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final Function() onSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authInfoProvider);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(image: AssetImage(TezdaImages.icon)),
            ),
          ),
          const SizedBox(height: 20),
          Text('Get Started!', style: context.textTheme.titleLarge),
          Text('Register and begin enjoying quality products.', style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
              validator: (value) => Helpers.fieldValidator(context, value),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (value) => Helpers.registerValidator(context, value, false),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              validator: (value) => Helpers.registerValidator(context, value, true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
              validator: (value) {
                if ((value ?? '').trim() != _passwordController.text.trim()) {
                  return 'Passwords do not match';
                }
              },
            ),
          ),
          const Spacer(),
          switch (authState) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            _ => ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    bool success = await ref.read(authInfoProvider.notifier).register(
                          password: _passwordController.text.trim(),
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                        );
                    if (success) {
                      onSuccess();
                    }
                  }
                },
                child: const Text('Proceed'),
              ),
          },
          Center(
            child: InkWell(
              onTap: onSuccess,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('Head on to login, if you have registered.', style: context.textTheme.bodySmall!.copyWith(color: TezdaColors.primary)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.onSuccess,
    required this.onBack,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Function() onSuccess;
  final Function() onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authInfoProvider);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onBack,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: TezdaColors.grey,
              ),
              child: const Icon(CupertinoIcons.chevron_back),
            ),
          ),
          const SizedBox(height: 20),
          Text('Jump right in!', style: context.textTheme.titleLarge),
          Text('Login and begin enjoying quality products.', style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (value) => Helpers.registerValidator(context, value, false),
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              validator: (value) => Helpers.registerValidator(context, value, true),
            ),
          ),
          const Spacer(),
          switch (authState) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            _ => ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    final success = await ref.watch(authInfoProvider.notifier).login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                    if (success) {
                      onSuccess();
                    }
                  }
                },
                child: const Text('Welcome'),
              ),
          },
        ],
      ),
    );
  }
}
