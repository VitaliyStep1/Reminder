import ProjectDescription

let projectSettings: Settings = .settings(
  base: [
    "CODE_SIGN_STYLE": "Automatic",
    "CURRENT_PROJECT_VERSION": "1",
    "MARKETING_VERSION": "1.0",
    "SWIFT_VERSION": "5.0",
    "IPHONEOS_DEPLOYMENT_TARGET": "17.0"
  ],
  configurations: [
    .debug(name: "Debug"),
    .release(name: "Release")
  ],
  defaultSettings: .recommended
)

let appSettings: Settings = .settings(
  base: [
    "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
    "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
    "ENABLE_PREVIEWS": "YES",
    "GENERATE_INFOPLIST_FILE": "YES",
    "INFOPLIST_KEY_UIApplicationSceneManifest_Generation": "YES",
    "INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents": "YES",
    "INFOPLIST_KEY_UILaunchScreen_Generation": "YES",
    "INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad": "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown",
    "INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone": "UIInterfaceOrientationPortrait",
    "LD_RUNPATH_SEARCH_PATHS": ["$(inherited)", "@executable_path/Frameworks"],
    "SWIFT_EMIT_LOC_STRINGS": "YES",
    "TARGETED_DEVICE_FAMILY": "1,2",
    "DEVELOPMENT_LANGUAGE": "en",
  ]
)

let project = Project(
  name: "Reminder",
  settings: projectSettings,
  targets: [
    .target(
      name: "Reminder",
      destinations: .iOS,
      product: .app,
      bundleId: "com.ojexsoft.Reminder",
//      infoPlist: .default,
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "CFBundleDevelopmentRegion": "en",
          "CFBundleLocalizations": [
            "en",
            "uk"
          ],
        ]
      ),
      buildableFolders: [
        "Reminder/Sources",
        "Reminder/Resources",
      ],
      dependencies: [
        .external(name: "ReminderConfigurations"),
        .external(name: "ReminderAppDI"),
        .external(name: "ReminderDependencies"),
        .external(name: "ReminderDomain"),
        .external(name: "ReminderDomainContracts"),
        .external(name: "ReminderPersistence"),
        .external(name: "ReminderPersistenceContracts"),
        .external(name: "ReminderUserDefaultsStorage"),
        .external(name: "ReminderMainTabViewContracts"),
        .external(name: "ReminderNavigationContracts"),
        .external(name: "ReminderDesignSystem"),
        .external(name: "ReminderStart"),
        .external(name: "ReminderMainTabView"),
        .external(name: "ReminderClosest"),
        .external(name: "ReminderCreate"),
        .external(name: "ReminderSettings"),
      ],
      settings: appSettings
    ),
  ]
)
