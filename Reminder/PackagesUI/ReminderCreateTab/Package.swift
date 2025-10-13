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
      .package(path: "ReminderNavigationContracts"),
    ],
    targets: [
        .target(
            name: "ReminderCreateTab",
            dependencies: [
              "ReminderNavigationContracts"
            ]
        ),

    ]
)
