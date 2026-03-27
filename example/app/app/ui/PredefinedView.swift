import SwiftUI
import AffiseAttributionLib

extension Predefined {
    var typeTitle: String {
        String(describing: type(of: self))
    }
    
    var valueTitle: String {
        value().uppercased()
    }
}


struct PredefinedData {
    let predefined: any Predefined
    var data: Any
}


@available(iOS 13.0, *)
struct PredefinedView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @State private var predefineSelected: any Predefined = PredefinedFloat.REVENUE
    @State private var predefinedList: [PredefinedData] = []
    
    var body: some View {
        VStack(spacing: 16) {
            Toggle("Use custom Predefined", isOn: $appSettings.useCustomPredefined)
            NewPredefined(
                predefineSelected: $predefineSelected,
                predefinedList: $predefinedList
            )
            List {
                ForEach(Array(predefinedList.enumerated()), id: \.offset) { index, predefined in
                    PredefinedCard(predefined: predefined) {
                        predefinedList.remove(at: index)
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear {
            predefinedList = appSettings.predefinedList
        }
        .onChange(of: predefinedList.count) { _ in
            appSettings.predefinedList = predefinedList
        }
        .onChange(of: predefinedList.map { "\($0.predefined.value())=\(String(describing: $0.data))" }) { _ in
            appSettings.predefinedList = predefinedList
        }
    }
}

@available(iOS 13.0, *)
struct NewPredefined: View {
    
    let allPredefined: [any Predefined] = [
        PredefinedFloat.allCases as [any Predefined],
        PredefinedLong.allCases as [any Predefined],
        PredefinedString.allCases as [any Predefined],
    ].flatMap { $0 }
    
    @Binding var predefineSelected: any Predefined
    @Binding var predefinedList: [PredefinedData]
    @State private var predefinedValue = ""
    @State private var validationMessage: String?
    
    var body: some View {
        VStack(spacing: 12) {
            Menu {
                ForEach(Array(allPredefined.enumerated()), id: \.offset) { _, predefined in
                    Button(predefined.valueTitle) {
                        predefineSelected = predefined
                    }
                }
            } label: {
                HStack {
                    Text(selectedTitle)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            }
            
            TextField("Predefined value", text: $predefinedValue)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            if let validationMessage {
                Text(validationMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button("Add Predefined") {
                guard let typedValue = typedPredefinedValue() else {
                    validationMessage = validationText
                    return
                }
                
                validationMessage = nil
                
                if let index = predefinedList.firstIndex(where: {
                    $0.predefined.value() == predefineSelected.value()
                }) {
                    predefinedList[index].data = typedValue
                } else {
                    predefinedList.append(
                        PredefinedData(
                            predefined: predefineSelected,
                            data: typedValue
                        )
                    )
                }
                predefinedValue = ""
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .foregroundColor(.white)
            .background(Color(red: 76 / 255, green: 94 / 255, blue: 139 / 255))
            .cornerRadius(10)
        }
    }
    
    private var selectedTitle: String {
        title(for: predefineSelected)
    }
    
    private func title(for predefined: any Predefined) -> String {
        "\(predefined.typeTitle).\(predefined.valueTitle)"
    }
    
    private func typedPredefinedValue() -> Any? {
        if predefineSelected is PredefinedString {
            return predefinedValue
        }
        
        if predefineSelected is PredefinedLong {
            return Int64(predefinedValue)
        }
        
        if predefineSelected is PredefinedFloat {
            return Float(predefinedValue)
        }
        
        return nil
    }
    
    private var validationText: String {
        if predefineSelected is PredefinedLong {
            return "Value must be Int64 for the selected predefined."
        }
        
        if predefineSelected is PredefinedFloat {
            return "Value must be Float for the selected predefined."
        }
        
        return "Value does not match the selected predefined type."
    }
}

@available(iOS 13.0, *)
struct PredefinedCard: View {
    let predefined: PredefinedData
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(predefined.predefined.typeTitle)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(predefined.predefined.valueTitle)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text(String(describing: predefined.data))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 18, height: 18)
                    .padding(10)
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
    }
}


@available(iOS 13.0, *)
struct PredefinedView_Previews: PreviewProvider {
    static var previews: some View {
        PredefinedView()
    }
}
