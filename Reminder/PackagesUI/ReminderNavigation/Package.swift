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
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "../ReminderConfigurations"),
      .package(path: "../ReminderStartUI"),
      .package(path: "../ReminderMainTabView"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderCreateTab"),
      .package(path: "../ReminderClosestTab"),
      .package(path: "../ReminderDomainContracts"),
    ],
    targets: [
        .target(
          name: "ReminderNavigation",
          dependencies: [
            .product(name: "Swinject", package: "Swinject"),
            "ReminderConfigurations",
            "ReminderStartUI",
            "ReminderMainTabView",
            "ReminderNavigationContracts",
            "ReminderCreateTab",
            "ReminderClosestTab",
            "ReminderDomainContracts",
          ]
        ),
    ]
)
