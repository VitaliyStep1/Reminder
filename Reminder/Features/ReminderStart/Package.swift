// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderStart",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderStart",
            targets: ["ReminderStart"]),
    ],
    dependencies: [
      .package(path: "../ReminderConfigurations"),
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderDomain"),
      .package(path: "../ReminderDomainContracts"),
      .package(path: "../ReminderSharedUI"),
      .package(path: "../ReminderClosest"),
      .package(path: "../ReminderCreate"),
      .package(path: "../ReminderMainTabView"),
      .package(path: "../ReminderSettings"),
      .package(path: "../ReminderResolver"),
    ],
    targets: [
        .target(
            name: "ReminderStart",
            dependencies: [
              "ReminderConfigurations",
              "ReminderNavigationContracts",
              "ReminderDomain",
              "ReminderDomainContracts",
              "ReminderSharedUI",
              "ReminderClosest",
              "ReminderCreate",
              "ReminderMainTabView",
              "ReminderSettings",
              "ReminderResolver",
            ],
            resources: [
              .process("Resources")
            ]
        ),

    ]
)
