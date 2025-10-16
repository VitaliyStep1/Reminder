// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderResolver",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderResolver",
            targets: ["ReminderResolver"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "../ReminderPersistenceContracts"),
      .package(path: "../ReminderDomainContracts"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderConfigurations"),
    ],
    targets: [
        .target(
            name: "ReminderResolver",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderPersistenceContracts",
              "ReminderDomainContracts",
              "ReminderNavigationContracts",
              "ReminderConfigurations",
            ]),

    ]
)
