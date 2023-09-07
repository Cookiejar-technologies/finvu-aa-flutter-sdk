## Usage

Follow the steps below for the SDK Usage.
This SDK uses [Riverpod](https://pub.dev/packages/riverpod) for efficient state management.

1. Add riverpod as a dependency to the project.
2. Wrap the entry point of your flutter app with `ProviderScope`.

    ```dart
    void main() {
        runApp(const ProviderScope(child: MyApp()));
    }

    class MyApp extends StatelessWidget {
        const MyApp({super.key});

        // This widget is the root of your application.
        @override
        Widget build(BuildContext context) {
            return const MaterialApp(
                title: 'Flutter Demo',
                home: Home(),
            );
        }
    }
    ```
3. Import the package into the flutter project.
    ```dart 
    import 'package:finvu_bank_pfm/finvu_bank_pfm.dart';
    ```
4. `Navigator.push` to the class `FinvuBankPFM()` or you can add `FinvuBankPFM()` to a stateless widget as well. The FinvuBankPFM class takes in the users mobile number.

    ```dart
    FinvuBankPFM(mobileNo: "1234567890");
    ```


