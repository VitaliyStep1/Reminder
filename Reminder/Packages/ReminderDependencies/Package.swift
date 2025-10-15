// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderDependencies",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderDependencies",
            targets: ["ReminderDependencies"]),
    ],
    dependencies: [
      .package(path: "../ReminderResolver"),
      .package(path: "../ReminderDomain"),
      .package(path: "../ReminderPersistence"),
      .package(path: "../ReminderNavigation"),
      .package(path: "../ReminderStartUI"),
      .package(path: "../ReminderNavigationContracts"),
    ],
    targets: [
        .target(
          name: "ReminderDependencies",
          dependencies: [
            "ReminderResolver",
            "ReminderDomain",
            "ReminderPersistence",
            "ReminderNavigation",
            "ReminderStartUI",
            "ReminderNavigationContracts",
          ]),

    ]
)
