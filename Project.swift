import ProjectDescription

let project = Project(
    name: "ReferenceWallet",
    organizationName: "spruceid.com",
    packages: [
        .package(url: "https://github.com/spruceid/wallet-sdk-swift", from: "0.0.3"),
        // .package(path: "../wallet-sdk-swift")
    ],
    settings: .settings(base: [
        "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
        "ENABLE_MODULE_VERIFIER": "YES",
        "DEVELOPMENT_TEAM": "FZVYR3KYL4"
    ]),
    targets: [
        Target(
            name: "App",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.spruceid.wallet",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "CFBundleDisplayName": "SpruceID Wallet",
                "NSBluetoothAlwaysUsageDescription": "Secure transmission of mobile DL data",
                "UILaunchScreen": [:]
            ]),
            sources: ["Targets/App/Sources/**"],
            dependencies: [
                .target(name: "AppKit"),
                .target(name: "AppUI"),
            ]
        ),
        Target(
            name: "AppKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.kit",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppKit/Sources/**"],
            dependencies: [ ]
        ),
        Target(
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
        Target(
            name: "AppUI",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.ui",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/AppUI/Sources/**"],
            dependencies: [
                .package(product: "WalletSdk", type: .runtime),
            ]
        ),
        Target(
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
    ]
)
