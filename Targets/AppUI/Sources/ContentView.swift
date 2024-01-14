import SwiftUI
import WalletSdk

public struct ContentView: View {
    public init() {}

    public var body: some View {
        Text(helloRust())
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
