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
    targets: [
        .target(
            name: "ReminderSettingsTab"),

    ]
)
