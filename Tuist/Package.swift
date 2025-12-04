// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "ReminderTuistSupport",
  platforms: [
    .iOS(.v17)
  ],
  dependencies: [
    .package(path: "../Reminder/Foundation/ReminderConfigurations"),
    .package(path: "../Reminder/Foundation/ReminderAppDI"),
    .package(path: "../Reminder/Foundation/ReminderDomainContracts"),
    .package(path: "../Reminder/Foundation/ReminderDomain"),
    .package(path: "../Reminder/Foundation/ReminderPersistenceContracts"),
    .package(path: "../Reminder/Foundation/ReminderPersistence"),
    .package(path: "../Reminder/Foundation/ReminderDependencies"),
    .package(path: "../Reminder/Foundation/ReminderUserDefaultsStorage"),
    
    .package(path: "../Reminder/UIComponents/ReminderDesignSystem"),
    .package(path: "../Reminder/UIComponents/ReminderNavigationContracts"),
    .package(path: "../Reminder/UIComponents/ReminderMainTabViewContracts"),
    
    .package(path: "../Reminder/Features/ReminderStart"),
    .package(path: "../Reminder/Features/ReminderMainTabView"),
    .package(path: "../Reminder/Features/ReminderCreate"),
    .package(path: "../Reminder/Features/ReminderClosest"),
    .package(path: "../Reminder/Features/ReminderSettings"),
  ]
)
