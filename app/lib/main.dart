import 'package:app/controller/employee_controller.dart';
import 'package:app/models/employee_model/employee_model.dart';
import 'package:app/states/employee_state.dart';
import 'package:app/theme/theme_constants.dart';
import 'package:app/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sizer/sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

void showSuccessToast(
    BuildContext context, String message, Color successToastBg) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      backgroundColor: successToastBg,
      message: message,
    ),
  );
}

ThemeManager _themeManager = ThemeManager();
final themeModeProvider = StateProvider<bool>(
    // We return the default sort type, here name.
    (ref) => false);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeManager.themeMode,
          home: const MyHomePage(title: 'App'),
        );
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool isChecked = false;
  List<EmployeeModel> employeeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeControllerProvider.notifier).getAllEmployee();
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkEmployeeState(context);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FlutterSwitch(
                height: 4.h,
                width: 12.w,
                padding: 4.0,
                toggleSize: 20.0,
                borderRadius: 30,
                activeColor: Colors.black,
                inactiveColor: Colors.white,
                activeToggleColor: Colors.white,
                inactiveToggleColor: Colors.black,
                value: isChecked = _themeManager.themeMode == ThemeMode.dark,
                onToggle: (value) {
                  _themeManager.toggleTheme(value);
                  ref.read(themeModeProvider.notifier).state = value;
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Column(
            children: [
              Text(
                "I couldn't consume the given api due to limited request so i used JSONPLACEHOLDER",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.only(top: 5.h),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var element in employeeList) ...[
                        SizedBox(
                          height: 35.h,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CardItem(
                                name: element.name ?? "",
                                email: element.email ?? ""),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void checkEmployeeState(BuildContext context) {
    final state = ref.watch(employeeControllerProvider);
    if (state is EmployeeStateSuccess) {
      final successState = state.details;
      if (successState.isNotEmpty) {
        setState(() {
          employeeList = successState;
        });
      }
    }
    if (state is EmployeeStateError) {
      showSuccessToast(context, state.error.text, Colors.red);
    }
  }
}

class CardItem extends ConsumerWidget {
  const CardItem({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Container(
      width: 55.w,
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      decoration: BoxDecoration(
          color: colorTheme.primaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
            width: 55.w,
            child: Image(
              image: NetworkImage(
                  "https://img.freepik.com/premium-vector/young-smiling-man-avatar-man-with-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-3d-vector-people-character-illustration-cartoon-minimal-style_365941-860.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 1.5.h)),
          Text(
            name,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 1.h)),
          Text(
            email,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Padding(padding: EdgeInsets.only(top: 1.2.h)),
          Container(
            decoration: BoxDecoration(
                color: Colors.yellow[300],
                borderRadius: BorderRadius.all(Radius.circular(15))),
            padding: EdgeInsets.all(6),
            child: Text(
              "View More",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorTheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
