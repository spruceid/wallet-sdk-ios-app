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
                "CFBundleVersion": "0.0.1",
                "CFBundleShortVersionString": "0.0.1",
                "CFBundleDisplayName": "SpruceKit Wallet",
                "CFBundleIconName": "AppIcon",
                "CFBundlePackageType": "APPL",
                "NSBluetoothAlwaysUsageDescription": "Secure transmission of mobile DL data",
                "UILaunchScreen": [:]
            ]),
            sources: ["Targets/App/Sources/**"],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .target(name: "AppAppKit"),
                .target(name: "AppUIKit"),
            ]
        ),
        .target(
            name: "AppAppKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.kit",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppAppKit/Sources/**"],
            dependencies: [ ]
        ),
        .target(
            name: "AppAppKitTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.kittests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppAppKit/Tests/**"],
            dependencies: [
                .target(name: "AppAppKit")
            ]
        ),
        .target(
            name: "AppUIKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.ui",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppUIKit/Sources/**"],
            dependencies: [
                .package(product: "SpruceIDWalletSdk", type: .runtime),
            ]
        ),
        .target(
            name: "AppUIKitTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.uitests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppUIKit/Tests/**"],
            dependencies: [
                .target(name: "AppUIKit")
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
