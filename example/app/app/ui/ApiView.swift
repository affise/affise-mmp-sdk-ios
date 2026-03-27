import SwiftUI
import AffiseAttributionLib


@available(iOS 13.0, *)
struct ApiView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @State private var outputValue = ""
    @State private var api: [ApiAction] = []
    
    var body: some View {
        VStack(spacing: 12) {
            TextField("API Output", text: $outputValue)
                .disabled(true)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(Array(api.enumerated()), id: \.offset) { _, item in
                        AffiseButton(title: item.title) {
                            item.action()
                        }
                    }
                    
                    if Affise.Module.Link.hasModule() {
                        ModuleLink(outputValue: $outputValue)
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            api = makeApi()
        }
    }
    
    private func makeApi() -> [ApiAction] {
        ApiFactory().createActions(
            output: { output in
                DispatchQueue.main.async {
                    outputValue = output
                }
            },
            appSettings: appSettings
        )
    }
}

@available(iOS 13.0, *)
private struct ModuleLink: View {
    @State private var resolveUrl = ""
    @Binding var outputValue: String
    
    var body: some View {
        VStack(spacing: 8) {
            TextField("Resolve URL", text: $resolveUrl)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            AffiseButton(title: "Module.Link resolve") {
                Affise.Module.Link.resolve(resolveUrl) { result in
                    DispatchQueue.main.async {
                        outputValue = result
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}


@available(iOS 13.0, *)
struct ApiView_Previews: PreviewProvider {
    static var previews: some View {
        ApiView()
    }
}
