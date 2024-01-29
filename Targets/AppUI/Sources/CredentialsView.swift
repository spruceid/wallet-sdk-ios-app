import SwiftUI
import WalletSdk

public struct CredentialsView: View {
    @Binding var credentials: CredentialStore
    
    public var body: some View {
        List(credentials.credentials) { credential in
            Text(credential.id)
        }
    }
}


struct CredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        let credentials = [generateMDoc()!]
        CredentialsView(credentials: .constant(CredentialStore(credentials: credentials)))
    }
}
