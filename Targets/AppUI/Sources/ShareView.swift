import CoreImage.CIFilterBuiltins
import SwiftUI
import WalletSdk

public struct ShareView: View {
    @Binding var credentials: CredentialStore
    @State private var showingQRSheet = false
    
    init(credentials: Binding<CredentialStore>) {
        self._credentials = credentials
    }
    
    public var body: some View {
        Button("Present with QR Code") {
            showingQRSheet.toggle()
        }
        .padding(10)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showingQRSheet) {
            QRSheetView(credentials: $credentials)
        }
    }
}

func generateQRCode(from data: Data) -> UIImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = data
    if let outputImage = filter.outputImage {
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgimg)
        }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
}

public struct QRSheetView: View {
    @Binding var credentials: CredentialStore
    @StateObject var delegate: ShareViewDelegate
    @Environment(\.presentationMode) var presentationMode
    
    init(credentials: Binding<CredentialStore>) {
        self._credentials = credentials
        self._delegate = StateObject(wrappedValue: ShareViewDelegate(credentials: credentials.wrappedValue))
    }
    
    public var body: some View {
        VStack {
            switch self.delegate.state {
            case .engagingQRCode(let data):
                VStack {
                    Text("Present QR code to reader")
                    Image(uiImage: generateQRCode(from: data))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                }
            case .error(let error):
                Text(error)
            case .progress(let message):
                Text(message)
            case .success:
                let _ = presentationMode.wrappedValue.dismiss()
                Text("Success")
            case .selectNamespaces(let items):
                SelectiveDisclosureView(itemsRequests: items, delegate: delegate)
            }
            Button("Cancel") {
                self.delegate.cancel(credentials: self.credentials)
                presentationMode.wrappedValue.dismiss()
            }.padding(10).buttonStyle(.bordered).tint(.red).foregroundColor(.red)
        }
    }
}

class ShareViewDelegate: ObservableObject {
    @Published var state: BLESessionState
    private var sessionManager: BLESessionManager?
    
    init(credentials: CredentialStore) {
        self.state = .progress("Starting")
        self.sessionManager = nil
        self.sessionManager = credentials.presentMdocBLE(deviceEngagement: .QRCode, callback: self)!
    }
    
    func cancel(credentials: CredentialStore) {
        self.sessionManager?.cancel()
    }
    
    func submitItems(items: [String: [String: [String: Bool]]]) {
        self.sessionManager?.submitNamespaces(items: items.mapValues { namespaces in
            return namespaces.mapValues { items in
                Array(items.filter { $0.value }.keys)
            }
        })
    }
}

extension ShareViewDelegate: BLESessionStateDelegate {
    public func update(state: BLESessionState) {
        self.state = state
    }
}


struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        let credentials = [generateMDoc()!]
        ShareView(credentials: .constant(CredentialStore(credentials: credentials)))
    }
}
