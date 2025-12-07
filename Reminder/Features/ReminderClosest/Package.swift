// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderClosest",
    defaultLocalization: "en",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "ReminderClosest",
            targets: ["ReminderClosest"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderMainTabViewContracts"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderDesignSystem"),
      .package(path: "ReminderDomain"),
      .package(path: "Language"),
    ],
    targets: [
        .target(
            name: "ReminderClosest",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderMainTabViewContracts",
              "ReminderNavigationContracts",
              "ReminderDesignSystem",
              "ReminderDomain",
              "Language",
            ],
            resources: [
              .process("Resources")
            ]
        ),
    ]
)
