// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderSettings",
    platforms: [
      .iOS(.v17)
    ],
    products: [
        .library(
            name: "ReminderSettings",
            targets: ["ReminderSettings"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Swinject/Swinject.git", from: "2.10.0"),
      .package(path: "ReminderDomainContracts"),
      .package(path: "ReminderDesignSystem"),
      .package(path: "ReminderNavigationContracts"),
      .package(path: "ReminderResolver"),
    ],
    targets: [
        .target(
          name: "ReminderSettings",
          dependencies: [
            .product(name: "Swinject", package: "Swinject"),
            "ReminderDomainContracts",
            "ReminderNavigationContracts",
            "ReminderDesignSystem",
            "ReminderResolver",
          ],
          resources: [
            .process("Resources")
          ]
        ),

    ]
)
