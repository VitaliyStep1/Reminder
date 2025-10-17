// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderMainTabView",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderMainTabView",
            targets: ["ReminderMainTabView"]),
    ],
    dependencies: [
      .package(path: "../ReminderNavigationContracts"),
      .package(path: "../ReminderMainTabViewContracts"),
    ],
    targets: [
        .target(
            name: "ReminderMainTabView",
            dependencies: [
              "ReminderNavigationContracts",
              "ReminderMainTabViewContracts",
            ]
        ),

    ]
)
