// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderCreate",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderCreate",
            targets: ["ReminderCreate"]),
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
            name: "ReminderCreate",
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
