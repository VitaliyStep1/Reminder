// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderSettingsTab",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderSettingsTab",
            targets: ["ReminderSettingsTab"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderDomainContracts"),
      .package(path: "ReminderSharedUI"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderResolver"),
    ],
    targets: [
        .target(
          name: "ReminderSettingsTab",
          dependencies: [
            .product(name: "Swinject", package: "Swinject"),
            "ReminderDomainContracts",
            "ReminderNavigationContracts",
            "ReminderSharedUI",
            "ReminderResolver",
          ]
        ),

    ]
)
