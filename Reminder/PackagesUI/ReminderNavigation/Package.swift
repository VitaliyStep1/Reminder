// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderNavigation",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderNavigation",
            targets: ["ReminderNavigation"]),
    ],
    dependencies: [
      .package(path: "../ReminderConfigurations"),
      .package(path: "../ReminderStartUI"),
      .package(path: "../ReminderMainTabView"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderCreateTab"),
      .package(path: "../ReminderClosestTab"),
    ],
    targets: [
        .target(
          name: "ReminderNavigation",
          dependencies: [
            "ReminderConfigurations",
            "ReminderStartUI",
            "ReminderMainTabView",
            "ReminderNavigationContracts",
            "ReminderCreateTab",
            "ReminderClosestTab",
          ]
        ),
    ]
)
