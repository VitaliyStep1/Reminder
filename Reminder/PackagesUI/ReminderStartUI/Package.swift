// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderStartUI",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderStartUI",
            targets: ["ReminderStartUI"]),
    ],
    dependencies: [
      .package(path: "../ReminderConfigurations"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderDomain"),
      .package(path: "../ReminderDomainContracts"),
    ],
    targets: [
        .target(
            name: "ReminderStartUI",
            dependencies: [
              "ReminderConfigurations",
              "ReminderNavigationContracts",
              "ReminderDomain",
              "ReminderDomainContracts",
            ]
        ),

    ]
)
