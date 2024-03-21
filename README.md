# TextValidator
![Language:Swift](https://img.shields.io/static/v1?label=Language&message=Swift&color=green&style=flat-square)
[![License](https://img.shields.io/github/license/KantaSwift/CustomTabBar)](https://github.com/KantaSwift/CustomTabBar/blob/main/LICENSE)
[![Twitter](https://img.shields.io/twitter/follow/KantaSwift?style=social)](https://twitter.com/kanta_Swift)

#### You can easily implement validation

## Table of Contents

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Tips](#tips)
- [Validation Rules](#validation-rules)
- [UpComing](#upcoming)
- [Contribution](#contribution)


## Installation

### Swift Package Manager 

#### Package

You can add this package to `Package.swift`, include it in your target dependencies.

```
let package = Package(
    dependencies: [
        .package(url: "https://github.com/KantaSwift/TextValidator.git", .upToNextMajor(from: "0.0.2")),
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: ["ScreenSettings"]),
    ]
)
```

#### Xcode

You can add this package on Xcode.
See [documentation](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).


## Basic Usage

```swift
let validator = Validator<String>()

// Register validation rules
validator.add(text: "user@example.com", forKey: "email", using: [.email])
validator.add(text: "Password123!", forKey: "password", using: [.strongPassword])

// Validate and retrieve results
let emailValidation = validator.get(forKey: "email")
if emailValidation.isValid {
    print("Email is valid!")
} else {
    print("Email validation error: \(emailValidation.error ?? "Unknown error")")
}

// Check overall validation status
if validator.allValid() {
    print("All validations passed!")
} else {
    print("Some validations failed.")
}

```

To use the Validator library in a type-safe manner, first define your keys as an `enum`:

```swift
import Validator

// Define your keys as an enum for type safety
enum ValidationKey {
    case email
    case password
}

// Extend the enum to conform to `Hashable` if not already
extension ValidationKey: Hashable {}

// Initialize the validator with the specific key type
let validator = Validator<ValidationKey>()

// Register validation rules using the type-safe keys
validator.add(text: "user@example.com", forKey: .email, using: [.email])
validator.add(text: "Password123!", forKey: .password, using: [.strongPassword])

// Validate and retrieve results in a type-safe manner
let emailValidation = validator.get(forKey: .email)
if emailValidation.isValid {
    print("Email is valid!")
} else {
    print("Email validation error: \(emailValidation.error ?? "Unknown error")")
}

// To check overall validation status
if validator.allValid() {
    print("All validations passed!")
} else {
    print("Some validations failed.")
}
```

With this approach, you ensure that the keys used to register and retrieve validation results are restricted to those defined in the ValidationKey enum, which prevents typos and ensures that only valid keys are used throughout your code.

## Tips

### Check Partial Validation Results

If you need to check the validation status for a specific set of fields, you can use the `someValid` method for partial validation. This is particularly useful when you have multiple fields and you want to ensure that a subset of them is valid before proceeding. Here is how you can use it:
- Please refer to the following writing style

```swift
// Define your keys as an enum for type safety
enum ValidationKey: Hashable {
    case email
    case password
    case username
}

// Initialize the validator with the specific key type
let validator = Validator<ValidationKey>()

// Register validation rules for all the fields
validator.add(text: "user@example.com", forKey: .email, using: [.email])
validator.add(text: "Password123!", forKey: .password, using: [.strongPassword])
validator.add(text: "User123", forKey: .username, using: [.length(to: 10, from: 1)])

// If you need to check the validation for just email and username, use someValid:
if validator.someValid(for: [.email, .username]) {
    print("Email and username validations passed!")
} else {
    print("Some validations failed for email or username.")
}
````

### Combining Multiple Validation Rules

You can assign multiple validation rules to a single text field to ensure comprehensive validation. The Validator library processes these rules in the order they are given and applies all relevant checks:

```swift
validator.add(text: "user@example.com", forKey: .email, using: [.empty, .email])
```

### Error Message Priority
When multiple validations are set for a single field, error messages will be prioritized based on the severity of the validation rule. The first failing rule's error message will be returned, allowing you to present the most critical validation feedback to the user first:

```swift
validator.add(text: "abc", forKey: .password, using: [.empty, .length(to: 8, from: 6), .strongPassword])

let validationResult = validator.get(forKey: .password)
if !validationResult.isValid {
    print("Validation error: \(validationResult.error ?? "An error occurred")")
}
```
Here, if abc is the input for the password field, the error message for .length will be displayed before the error for .strongPassword since it fails the length check first.

## Validation Rules

The Validator library provides a set of built-in `ValidationRule`s that you can use to validate text fields. These rules include:

- `.empty`: Validates that the field is not empty.
- `.strongPassword`: Validates that the password is strong, which means it must contain uppercase and lowercase letters, numbers, and be at least 8 characters long.
- `.length(to: Int, from: Int?)`: Validates that the field's text is within the specified length range.
- `.email`: Validates that the field's text is a valid email format.

Here's an example of how to apply these rules:

```swift
// For an email field:
validator.add(text: "user@example.com", forKey: .email, using: [.email])

// For a password field:
validator.add(text: "Password123!", forKey: .password, using: [.strongPassword])

// For a username field with a specific length:
validator.add(text: "User123", forKey: .username, using: [.length(to: 10, from: 1)])

```

Each rule can be used individually or combined to create comprehensive validation for a text field.

:warning: Note: Custom validation rules are not supported at the current stage. We are exploring ways to allow custom rule definitions and hope to include this functionality in future updates. Stay tuned!

## UpComing
In future updates to the Validator library, we aim to introduce several enhancements to make your validation logic even more powerful:

- **Custom Validation Rules:** One of the most requested features is the ability to define custom validation rules. We're exploring ways to allow you to specify your own rules, providing greater flexibility and enabling you to tailor validation logic to your specific needs.

## Contribution
I would be happy if you contribute :)

- [New issue](https://github.com/KantaSwift/TextValidator/issues/new)
- [New pull request](https://github.com/KantaSwift/TextValidator/pulls)
