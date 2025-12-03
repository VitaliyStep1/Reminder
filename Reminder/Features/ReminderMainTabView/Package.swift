// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderMainTabView",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "ReminderMainTabView",
            targets: ["ReminderMainTabView"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderMainTabViewContracts"),
      .package(path: "ReminderResolver"),
      .package(path: "ReminderCreate"),
    ],
    targets: [
        .target(
            name: "ReminderMainTabView",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderNavigationContracts",
              "ReminderMainTabViewContracts",
              "ReminderResolver",
              "ReminderCreate",
            ],
            resources: [
              .process("Resources")
            ]
        ),

    ]
)
