import 'package:bctpay/globals/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    networkBloc.add(CheckConnection());
    DeviceInfo.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeLogoColorBlue,
      bottomNavigationBar: SizedBox(
          height: 50,
          child: Center(
              child: Text(
            appLocalizations(context).poweredBy,
            style: const TextStyle(color: Colors.white),
          ))),
      body: SafeArea(
        child: BlocConsumer<NetworkBloc, NetworkState>(
          bloc: networkBloc,
          listener: (context, state) async {
            if (state is ConnectionSuccess) {
              var isIntroShowed =
                  await SharedPreferenceHelper.getIsIntroShowed();
              Future.delayed(const Duration(seconds: 3)).whenComplete(() {
                SharedPreferenceHelper.getIsLogin().then(
                  (isLogin) {
                    if (!context.mounted) return null;
                    return Navigator.pushReplacementNamed(
                        context,
                        (isLogin
                            ? '/bottombar'
                            : isIntroShowed
                                ? '/login'
                                : '/intro'));
                  },
                );
              });
            }
          },
          builder: (context, state) {
            if (state is ConnectionInitial) {
              return _splash();
            }
            if (state is ConnectionSuccess) {
              return _splash();
            }
            if (state is ConnectionFailure) {
              return NoInternetScreen(
                onTap: () {
                  networkBloc.add(CheckConnection());
                },
              );
            }
            return _splash();
          },
        ),
      ),
    );
  }

  Widget _splash() => Container(
      color: themeLogoColorBlue,
      padding: const EdgeInsets.all(80),
      child: Center(child: Image.asset(Assets.assetsImagesBCTLogoLight)));
}
