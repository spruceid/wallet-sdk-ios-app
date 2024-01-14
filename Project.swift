import ProjectDescription

/*
                +-------------+
                |             |
                |     App     | Contains ReferenceWallet App target and ReferenceWallet unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

let project = Project(
    name: "ReferenceWallet",
    organizationName: "spruceid.com",
    settings: .settings(base: [
        "ENABLE_USER_SCRIPT_SANDBOXING": "YES",
        "ENABLE_MODULE_VERIFIER": "YES"
    ]),
    targets: [
        Target(
            name: "App",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.spruceid.wallet",
            deploymentTargets: .iOS("14.0"),
            infoPlist: .default,
            sources: ["Targets/App/Sources/**"],
            dependencies: [
                .external(name: "WalletSdk"),
                .target(name: "AppKit"),
                .target(name: "AppUI"),
            ]
        ),
        Target(
            name: "AppKit",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.spruceid.wallet.kit",
            deploymentTargets: .iOS("14.0"),
            infoPlist: .default,
            sources: ["Targets/AppKit/Sources/**"],
            dependencies: [ ]
        ),
        Target(
            name: "AppKitTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.kittests",
            deploymentTargets: .iOS("14.0"),
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
            deploymentTargets: .iOS("14.0"),
            infoPlist: .default,
            sources: ["Targets/AppUI/Sources/**"],
            dependencies: [ ]
        ),
        Target(
            name: "AppUITests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.spruceid.wallet.uitests",
            deploymentTargets: .iOS("14.0"),
            infoPlist: .default,
            sources: ["Targets/AppUI/Tests/**"],
            dependencies: [
                .target(name: "AppUI")
            ]
        )
    ]
)
