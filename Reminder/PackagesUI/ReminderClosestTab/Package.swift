// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderClosestTab",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderClosestTab",
            targets: ["ReminderClosestTab"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderMainTabViewContracts"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderSharedUI"),
      .package(path: "ReminderResolver")
    ],
    targets: [
        .target(
            name: "ReminderClosestTab",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderMainTabViewContracts",
              "ReminderNavigationContracts",
              "ReminderSharedUI",
              "ReminderResolver",
            ]
        ),
    ]
)
