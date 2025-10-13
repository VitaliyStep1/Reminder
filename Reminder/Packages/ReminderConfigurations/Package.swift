// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderConfigurations",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderConfigurations",
            targets: ["ReminderConfigurations"]),
    ],
    targets: [
        .target(
            name: "ReminderConfigurations"),
    ]
)
