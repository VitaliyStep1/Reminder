// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReminderClosestTab",
    platforms: [
      .iOS(.v16)
    ],
    products: [
        .library(
            name: "ReminderClosestTab",
            targets: ["ReminderClosestTab"]),
    ],
    dependencies: [
      .package(path: "../ReminderMainTabViewContracts"),
    ],
    targets: [
        .target(
            name: "ReminderClosestTab",
            dependencies: [
              "ReminderMainTabViewContracts",
            ]
        ),
    ]
)
