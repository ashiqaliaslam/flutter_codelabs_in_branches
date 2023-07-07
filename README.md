# [Dart Null Safety Codelab](https://dart.dev/codelabs/null-safety)

Dart introduced null safety as an optional setting in Dart 2.12. Dart 3 requires null safety. With null safety, values can’t be `null` unless you say they can be.

## Nullable and non-nullable types

With [null safety](https://dart.dev/null-safety#enable-null-safety), all types default to non-nullable. For example, if you have a variable of type `String`, it always contains a string.

To allow a variable of type `String` to accept any string or the value `null`, add a question mark (`?`) after the type name. This changes the type of variable to a nullable type. For example, a variable of type `String?` can contain a string, or it can be null.

## Non-nullable types

```dart
void main() {
  int a;
  a = null; // 
  print('a is $a.');
}

/// Error
// A value of type 'Null' can't be assigned to a variable of type 'int'.
// Try changing the type of the variable, or casting the right-hand type to 'int'.
```

## Nullable types

set by assigning a `int` to `int` variable

```dart
void main() {
  int a;
  a = 3;
  print('a is $a.');
}

/// Output
// a is 3.
```

Make `int` variable `a` a nullalbe (it can be `null`)

```dart
void main() {
  int? a;
  a = null;
  print('a is $a.');
}

/// Output
// a is null.
```

## Nullable type parameters for generics

Type parameters for generics can also be nullable or non-nullable.

```dart
void main() {
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String> aNullableListOfStrings;
  List<String> aListOfNullableStrings = ['one', null, 'three']; // Error1

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.'); // Error2
  print('aListOfNullableStrings is $aListOfNullableStrings.');
}

/// Error1
// The non-nullable local variable 'aNullableListOfStrings' must be assigned before it can be used.
/// Error2
// Try giving it an initializer expression, or ensure that it's assigned on every execution path.
```

Fix the code by making list or list items nullable

```dart
void main() {
  List<String> aListOfStrings = ['one', 'two', 'three'];
  List<String>? aNullableListOfStrings; // whole list could be null
    // list item could be null
  List<String?> aListOfNullableStrings = ['one', null, 'three']; 

  print('aListOfStrings is $aListOfStrings.');
  print('aNullableListOfStrings is $aNullableListOfStrings.');
  print('aListOfNullableStrings is $aListOfNullableStrings.');
}

/// Output
// aListOfStrings is [one, two, three].
// aNullableListOfStrings is null.
// aListOfNullableStrings is [one, null, three].
```

## The null assertion operator (!)

If you’re sure an expression with a nullable type doesn’t equal `null`, you can use the [null assertion operator](https://dart.dev/null-safety/understanding-null-safety#null-assertion-operator) (`!`) to make Dart treat it as non-nullable. By adding `!` after the expression, you assert two conditions to Dart about the expression:

1. Its value doesn’t equal `null`
2. Dart can assign the value to a non-nullable variable

> If the expression does equal `null`, **Dart throws an exception at run-time**. This makes the `!` operator *unsafe*. Don’t use it unless you have no doubt the expression can’t equal `null`.
>

```dart
int? couldReturnNullButDoesnt() => -3;
int? couldBeNullButIsnt = 1;

void main() {
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt; // out of scope
  int b = listThatCouldHoldNulls.first; // first item in the list
  int c = couldReturnNullButDoesnt().abs(); // absolute value

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

/// Output
// A value of type 'int?' can't be assigned to a variable of type 'int'.
// Try changing the type of the variable, or casting the right-hand type to 'int'.

// A value of type 'int?' can't be assigned to a variable of type 'int'.
// Try changing the type of the variable, or casting the right-hand type to 'int'.

// The method 'abs' can't be unconditionally invoked because the receiver can be 'null'.
// Try making the call conditional (using '?.') or adding a null check to the target ('!').
```

Because we know varialbes are not null so we used null assertion operator

```dart
int? couldReturnNullButDoesnt() => -3;
int? couldBeNullButIsnt = 1;

void main() {
  List<int?> listThatCouldHoldNulls = [2, null, 4];

  int a = couldBeNullButIsnt!;
  int b = listThatCouldHoldNulls.first!;
  int c = couldReturnNullButDoesnt()!.abs(); 

  print('a is $a.');
  print('b is $b.');
  print('c is $c.');
}

/// Output
// a is 1.
// b is 2.
// c is 3.
```

## The `required` keyword

```dart
int addThreeValues({
  int first, // Error1
  int second, // Error2
  int third, // Error3
}) {
  return first + second + third;
}

void main() {
  final sum = addThreeValues(
    first: 2,
    second: 5,
    third: 3,
  );

  print(sum);
}


/// Output
// The parameter 'first' can't have a value of 'null' because of its type, but the implicit default value is 'null'.
// The parameter 'second' can't have a value of 'null' because of its type, but the implicit default value is 'null'.
// The parameter 'third' can't have a value of 'null' because of its type, but the implicit default value is 'null'.
```

Mark non-nullable named parameters `required`

```dart
int addThreeValues({
  required int first, // Error1
  required int second, // Error2
  required int third, // Error3
}) {
  return first + second + third;
}

void main() {
  final sum = addThreeValues(
    first: 2,
    second: 5,
    third: 3,
  );

  print(sum);
}


/// Output
// 10
```

## Null-aware operators

If a variable or expression is nullable, you can use [type promotion](https://dart.dev/codelabs/null-safety#type-promotion) to access the type’s members. You can also use null-aware operators to handle nullable values.

Sometimes the flow of the program tells you that the value of an expression cannot be `null`. To force Dart to treat that expression as non-nullable, add the [null assertion operator](https://dart.dev/codelabs/null-safety#the-null-assertion-operator-) (`!`). If the value does equal `null`, using this operator throws an exception.

To handle potential `null` values, use the conditional property access operator (`?.`) or null-coalescing operators (`??`) to conditionally access a property or provide a default value if `null` respectively.

### Conditional property access operator `?.`

If you don’t know that an expression with a nullable type equals `null` or not, you can use the conditional member access operator (`?.`). This operator evaluates to `null` if the target expression resolves to `null`. Otherwise, it accesses the property on the non-null target value.

```dart
int? stringLength(String? nullableString) {
  return nullableString.length; // Error
}

void main() {
  print(stringLength('ok'));
}


/// Error
// The property 'length' can't be unconditionally accessed because the receiver can be 'null'.
// Try making the access conditional (using '?.') or adding a null check to the target ('!').
```

Fix by using access conditional `?.`

```dart
int? stringLength(String? nullableString) {
  return nullableString?.length; // Error
}

void main() {
  print(stringLength('ok'));
}


/// Error
// 2
```

Access conditional operator `?.` returns error if expression evaluates to null

```dart
int? stringLength(String? nullableString) {
  return nullableString?.length;
}

void main() {
  print(stringLength()); // Null parameter
}


/// Error
// 1 positional argument expected by 'stringLength', but 0 found.
// Try adding the missing argument.
```

### Null-coalescing operators `??`

If you want to provide an alternative value when the expression evaluates to `null`, you can specify another expression to evaluate and return instead with the null-coalescing operator (`??`).

```dart
// Both of the following print out 'alternate' if nullableString is null
print(nullableString ?? 'alternate');
print(nullableString != null ? nullableString : 'alternate');
```

You can also use the null-coalescing assignment operator (`??=`) to evaluate and assign an expression result to a variable only if that variable is currently `null`.

```dart
// Both of the following set nullableString to 'alternate' if it is null
nullableString ??= 'alternate';
nullableString = nullableString != null ? nullableString : 'alternate';
```

In the following code, try using these operators to implement `updateStoredValue` following the logic outlined in its documentation comment:

```dart
abstract class Store {
  int? storedNullableValue;

  /// If [storedNullableValue] is currently `null`,
  /// set it to the result of [calculateValue]
  /// or `0` if [calculateValue] returns `null`.
  void updateStoredValue() {
    TODO('Implement following documentation comment');
  }

  /// Calculates a value to be used,
  /// potentially `null`.
  int? calculateValue();
}
```

use of  null-coalescing assignment operator (`??=`)

```dart
abstract class Store {
  int? storedNullableValue;

  /// If [storedNullableValue] is currently `null`,
  /// set it to the result of [calculateValue]
  /// or `0` if [calculateValue] returns `null`.
  void updateStoredValue() {
    storedNullableValue ??= calculateValue() ?? 0;
  }

  /// Calculates a value to be used,
  /// potentially `null`.
  int? calculateValue();
}
```

## Type promotion

Dart’s [flow analysis](https://dart.dev/null-safety/understanding-null-safety#flow-analysis) accounts for nullability. Dart treats nullable variables with no ability to contain null values as non-nullable variables. We call this behavior [type promotion](https://dart.dev/null-safety/understanding-null-safety#type-promotion-on-null-checks).

### Definite assignment

Dart’s type system can track where variables are assigned and read. It can also verify that the developer assigned values to non-nullable variables before any code tries to read from those variables. This process is called [definite assignment](https://dart.dev/null-safety/understanding-null-safety#definite-assignment-analysis).

```dart
void main() {
  String text;

  print(text); // Error1
  print(text.length); // Error2
}

/// Output
// The non-nullable local variable 'text' must be assigned before it can be used.
// Try giving it an initializer expression, or ensure that it's assigned on every execution path.
```

Add conditions to fix errors

```dart
void main() {
  String text;

  if (DateTime.now().hour < 12) {
    text = "It's morning! Let's make aloo paratha!";
  } else {
    text = "It's afternoon! Let's make biryani!";
  }

  print(text); // Error1
  print(text.length); // Error2
}

/// Output
// It's afternoon! Let's make biryani!
// 35
```

### Type promotion via Null checking

Dart can also promote nullable variables to non-nullable ones when there's a null check in the same scope.

```dart
int getLength(String? str) {
  // Add null check here

  return str.length;
}

void main() {
  print(getLength('This is a string!'));
}

/// Output
// The property 'length' can't be unconditionally accessed because the receiver can be 'null'.
// Try making the access conditional (using '?.') or adding a null check to the target ('!').
```

add the condition to check null, removes error

```dart
int getLength(String? str) {
  if (str == null) {
    return 0;
  }

  return str.length;
}

void main() {
  print(getLength('This is a string!'));
}

/// Output
// 17
```

### Promotion via exceptions

Promotion works with exceptions as well as return statements. If you check a nullable variable for null and throw an exception, Dart will consider any future reads from that variable in the same scope to be null-safe.

```dart
int getLength(String? str) {
  // Add null check here

  return str.length; // Error
}

void main() {
  print(getLength('This is a string!'));
}

/// Output
// The property 'length' can't be unconditionally accessed because the receiver can be 'null'.
// Try making the access conditional (using '?.') or adding a null check to the target ('!').
```

Implement exception to fix null safety error

```dart
int getLength(String? str) {
  if (str == null) {
    throw 'Hey, that string was null!';
  }

  return str.length; // Error
}

void main() {
  print(getLength('This is a string!'));
}

/// Output
// 17
```

This null check throws an `Exception` instead of returning zero

```dart
int getLength(String? str) {
  if (str == null) {
    throw 'Hey, that string was null!';
  }

  return str.length; // Error
}

void main() {
  print(getLength()); // Exception
}

/// Output
// 1 positional argument expected by 'getLength', but 0 found.
// Try adding the missing argument.
```

## Object properties aren't promotable

A common "Huh?" moment when first learning to use Dart's null safety arrives the first time you do a null check on an object field. This is due to the fact that in Dart, object properties have getters and setters (either real or implied), and so something that looks like a typical value property can return different things when read twice in the same code block.

Fortunately, there's a simple trick to handle this: read the variable once and cache it in a local variable@

```dart
import 'dart:math';

class RandomStringProvider {
  String? get value => Random().nextBool() ? 'A String!' : null;
}

void printString(String str) => print(str);

void main() {
  final provider = RandomStringProvider();

  if (provider.value == null) {
    print('The value is null.');
  } else {
    print('The value is not null, so print it!');
    printString(provider.value); // Error
  }
}

/// Output
// The argument type 'String?' can't be assigned to the parameter type 'String'.
```

Assign getter value to local variable, fix the problem

```dart
import 'dart:math';

class RandomStringProvider {
  String? get value => Random().nextBool() ? 'A String!' : null;
}

void printString(String str) => print(str);

void main() {
  final provider = RandomStringProvider();

  final str = provider.value;

  if (str == null) {
    print('The value is null.');
  } else {
    print('The value is not null, so print it!');
    printString(str);
  }
}

/// Output
// The value is not null, so print it!
// A String!

// The value is null.
```

### Another tricky object property example

Even if a class doesn't define a getter for its property, it's possible for a subclass to implement one anyway. In this case, what looks like a straightforward property in `StringProvider` gets turned into a random value in `RandomStringProvider`.

When the code in `main` goes to access the value, even though `provider` is typed as `StringProvider`, it's holding a `RandomStringProvider`, illustrating why the value can't easily be promoted.

```dart
import 'dart:math';

class StringProvider {
  String? value = 'A String!';
}

class RandomStringProvider extends StringProvider {
  @override
  set value(String? v) {}

  @override
  String? get value => Random().nextBool() ? 'A String!' : null;
}

void printString(String str) => print(str);

void main() {
  StringProvider provider = RandomStringProvider();

  if (provider.value == null) {
    print('The value is null.');
    return;
  }

  printString(provider.value); // Error
}

/// Output
// The argument type 'String?' can't be assigned to the parameter type 'String'.
```

fixing the error

```dart
import 'dart:math';

class StringProvider {
  String? value = 'A String!';
}

class RandomStringProvider extends StringProvider {
  @override
  set value(String? v) {}

  @override
  String? get value => Random().nextBool() ? 'A String!' : null;
}

void printString(String str) => print(str);

void main() {
  StringProvider provider = RandomStringProvider();

  final str = provider.value;

  if (str == null) {
    print('The value is null.');
  } else {
    print('ok');
    printString(str);
  }
}

/// Output
// ok
// A String!

// The value is null.
```

## The late keyword

Sometimes variables—fields in a class, or top-level variables—should be non-nullable, but they can’t be assigned a value immediately. For cases like that, use the [`late` keyword](https://dart.dev/null-safety/understanding-null-safety#late-variables).

When you put `late` in front of a variable declaration, that tells Dart the following about the variable:

- The developer didn’t want to assign it a value yet.
- It will get a value later.
- It will have a value *before* being used.

If you declare a variable `late` and Dart reads the variable before you assigned a value, Dart throws an error.

### Using late

```dart
class Meal {
  String _description; // Error

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

void main() {
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
}
/// Output
// Non-nullable instance field '_description' must be initialized.
// Try adding an initializer expression, or a generative constructor that initializes it, or mark it 'late'.
```

add `late` keyword

```dart
class Meal {
  late String _description; 

  set description(String desc) {
    _description = 'Meal description: $desc';
  }

  String get description => _description;
}

void main() {
  final myMeal = Meal();
  myMeal.description = 'Feijoada!';
  print(myMeal.description);
}
/// Output
// Meal description: Feijoada!
```

### Late circular references

The `late` keyword helps with tricky patterns like circular references. The following code has two objects that need to maintain non-nullable references to each other. Try using the `late` keyword to fix this code.

You don’t need to remove `final`. You can create [`late final` variables](https://dart.dev/null-safety/understanding-null-safety#late-final-variables): you set their values once, and after that they stay read-only.

```dart
class Team {
  final Coach coach;
}

class Coach {
  final Team team;
}

void main() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}

/// Output
// The final variable 'coach' must be initialized.
// Try initializing the variable.

// The final variable 'team' must be initialized.
// Try initializing the variable.

// 'coach' can't be used as a setter because it's final.
// Try finding a different setter, or making 'coach' non-final.

// 'team' can't be used as a setter because it's final.
// Try finding a different setter, or making 'team' non-final.
```

add `late` keywords

```dart
class Team {
  late final Coach coach;
}

class Coach {
  late final Team team;
}

void main() {
  final myTeam = Team();
  final myCoach = Coach();
  myTeam.coach = myCoach;
  myCoach.team = myTeam;

  print('All done!');
}

/// Output
// All done!
```

### Late and lazy

The `late` keyword can help with another pattern: [lazy initialization](https://dart.dev/null-safety/understanding-null-safety#lazy-initialization) for expensive non-nullable fields. Try the following:

```dart
int _computeValue() {
  print('In _computeValue...'); // 2
  return 3;
}

class CachedValueProvider {
  final _cache = _computeValue();
  int get value => _cache;
}

void main() {
  print('Calling constructor...'); // 1
  var provider = CachedValueProvider();
  print('Getting value...');      // 3
  print('The value is ${provider.value}!'); // 4
}

/// Output
// Calling constructor...
// In _computeValue...
// Getting value...
// The value is 3!
```

Making lazy with `late` keyword

```dart
int _computeValue() {
  print('In _computeValue...'); // 3
  return 3;
}

class CachedValueProvider {
  late final _cache = _computeValue();
  int get value => _cache;
}

void main() {
  print('Calling constructor...'); // 1
  var provider = CachedValueProvider();
  print('Getting value...'); // 2
  print('The value is ${provider.value}!'); // 4
}

/// Output
// Calling constructor...
// Getting value...
// In _computeValue...
// The value is 3!
```

**Fun fact:** After you add `late` to the declaration of `_cache`, if you move the `_computeValue` function into the `CachedValueProvider` class, the code still works! Initialization expressions for `late` fields can use instance methods in their initializers.

```dart
class CachedValueProvider {
  late final _cache = _computeValue();
  int get value => _cache;

  int _computeValue() {
    print('In _computeValue...'); // 3
    return 3;
  }
}

void main() {
  print('Calling constructor...'); // 1
  var provider = CachedValueProvider();
  print('Getting value...'); // 2
  print('The value is ${provider.value}!'); // 4
}

/// Output
// Calling constructor...
// Getting value...
// In _computeValue...
// The value is 3!
```
