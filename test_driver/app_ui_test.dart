import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_naming_convention/constants/strings.dart';
import 'package:test/test.dart';


void main() {

  group('flutter_naming_convention', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    final emailFormFinder = find.byValueKey(Strings.strEmailKey);
    final passFormFinder = find.byValueKey(Strings.strPassKey);
    final buttonFinder = find.byValueKey(Strings.strLoginKey);
    final itemFinder = find.byValueKey(Strings.strNewsKey);
    final addNewsFinder = find.byValueKey(Strings.strAddNewsKey);
    final updateNewsFinder = find.byValueKey(Strings.strUpdateNewsKey);
    final deleteNewsFinder = find.byValueKey(Strings.strDeleteNewsKey);
    final backKeyFinder = find.byValueKey(Strings.strBackKey);
    final photoFinder = find.byValueKey(Strings.strPhotoKey);


    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    Future<void> delay([int milliseconds = 250]) async {
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
    }


    //UI test for empty field validation
    test('empty_field_validation_test', () async {
      await driver.waitFor(buttonFinder);
      await delay(1000);
      await driver.tap(buttonFinder);
      await delay(1000);
      print('button tapped');
    });


    //UI test with wrong credential
    test('input_with_wrong_credential_test', () async {
      await driver.waitFor(emailFormFinder);
      await driver.tap(emailFormFinder);
      await driver.enterText('Student11');
      await delay(1000);
      print('entered text');

      await driver.waitFor(passFormFinder);
      await driver.tap(passFormFinder);
      await driver.enterText('Password12345');
      await delay(1000);
      print('entered number');

      await driver.waitFor(buttonFinder);
      await driver.tap(buttonFinder);
      await delay(1000);
      print('button tapped');
    });

    //UI test for email text form field
    test('email_enter_field_test', () async {
      await driver.waitFor(emailFormFinder);
      await driver.tap(emailFormFinder);
      await driver.enterText('Student11_1A');
      await delay(1000);
      print('entered text');
    });

    //UI test for password text form field
    test('password_enter_field_test', () async {
      await driver.waitFor(passFormFinder);
      await driver.tap(passFormFinder);
      await driver.enterText('Password12345');
      await delay(1000);
      print('entered number');
    });

    //UI test for login button tap
    test('button_tap_test', () async {
      await driver.waitFor(buttonFinder);
      await driver.tap(buttonFinder);
      await delay(1000);
      print('button tapped');
    });

    //UI test for get album list UI
    test('album_ui_test', () async {
      await driver.waitFor(photoFinder);
      await driver.tap(photoFinder);
      await delay(1000);
      print('display album list screen');
    });

    //UI test for back to dashboard screen
    test('back_to_dashboard_test', () async {
      await driver.waitFor(backKeyFinder);
      await driver.tap(backKeyFinder);
      await delay(1000);
      print('Back to dashboard screen');
    });

    //UI test for tap dashboard item
    test('item_tap_test', () async {
      await driver.waitFor(itemFinder);
      await driver.tap(itemFinder);
      await delay(1000);
      print('button tapped');
    });

    //UI test for news add, update and delete
    test('news_test', () async {
      await driver.waitFor(addNewsFinder);
      await driver.tap(addNewsFinder);
      await delay(1000);
      print('News added.');

      await driver.waitFor(updateNewsFinder);
      await driver.tap(updateNewsFinder);
      await delay(1000);
      print('News updated.');

      await driver.waitFor(deleteNewsFinder);
      await driver.tap(deleteNewsFinder);
      await delay(1000);
      print('News added.');
    });
  });
}
