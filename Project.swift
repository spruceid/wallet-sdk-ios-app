import ProjectDescription

let project = Project(
    name: "ReferenceWallet",
    organizationName: "spruceid.com",
    packages: [
        .package(url: "https://github.com/spruceid/wallet-sdk-swift", from: "0.0.6"),
        // .package(path: "../wallet-sdk-swift")
    ],
    settings: .settings(base: [
        "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
        "ENABLE_MODULE_VERIFIER": "YES",
        "DEVELOPMENT_TEAM": "FZVYR3KYL4"
        // "CODE_SIGN_IDENTITY": "Spruce Systems, Inc. (FZVYR3KYL4)"
    ]),
    targets: [
        .target(
            name: "App",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.spruceid.wallet",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "SpruceKit Wallet",
                "NSBluetoothAlwaysUsageDescription": "Secure transmission of mobile DL data",
                "UILaunchScreen": [:]
            ]),
            sources: ["Targets/App/Sources/**"],
            dependencies: [
                .target(name: "AppKit"),
                .target(name: "AppUI"),
            ]
        ),
        .target(
            name: "AppKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.kit",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppKit/Sources/**"],
            dependencies: [ ]
        ),
        .target(
            name: "AppKitTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.kittests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppKit/Tests/**"],
            dependencies: [
                .target(name: "AppKit")
            ]
        ),
        .target(
            name: "AppUI",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.ui",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppUI/Sources/**"],
            dependencies: [
                .package(product: "SpruceIDWalletSdk", type: .runtime),
            ]
        ),
        .target(
            name: "AppUITests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.uitests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppUI/Tests/**"],
            dependencies: [
                .target(name: "AppUI")
            ]
        )
    ],
    schemes: [
        .scheme(
            name: "release",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(executable: "App"),
            archiveAction: .archiveAction(configuration: .release)
        ),
        .scheme(
            name: "debug",
            shared: true,
            buildAction: .buildAction(targets: ["App"]),
            runAction: .runAction(executable: "App"),
            archiveAction: .archiveAction(configuration: .debug)
        )
    ]
)
