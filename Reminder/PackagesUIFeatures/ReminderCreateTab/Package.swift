// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderCreateTab",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderCreateTab",
            targets: ["ReminderCreateTab"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderDomainContracts"),
      .package(path: "ReminderSharedUI"),
      .package(path: "/ReminderResolver")
    ],
    targets: [
        .target(
            name: "ReminderCreateTab",
            dependencies: [
              .product(name: "Swinject", package: "Swinject"),
              "ReminderNavigationContracts",
              "ReminderDomainContracts",
              "ReminderSharedUI",
              "ReminderResolver",
            ],
            resources: [
              .process("Resources")
            ]
        ),

    ]
)
