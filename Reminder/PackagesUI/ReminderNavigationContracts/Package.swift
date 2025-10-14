// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderNavigationContracts",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderNavigationContracts",
            targets: ["ReminderNavigationContracts"]),
    ],
    dependencies: [
      .package(path: "../ReminderDomain")
    ],
    targets: [
        .target(
            name: "ReminderNavigationContracts",
            dependencies: [
              "ReminderDomain",
            ]
        ),

    ]
)
