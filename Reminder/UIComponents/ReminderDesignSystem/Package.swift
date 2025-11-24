// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderDesignSystem",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderDesignSystem",
            targets: ["ReminderDesignSystem"]),
    ],
    targets: [
        .target(
            name: "ReminderDesignSystem",
            resources: [
              .process("Resources")
            ]),

    ]
)
