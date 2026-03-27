import SwiftUI


@available(iOS 13.0, *)
struct MainView: View {
    @EnvironmentObject private var appSettings: AppSettings
    @State private var selectedTab: MainTab = .api
    @State private var isPredefinedView = false
    @State private var isSettingsView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                if isSettingsView {
                    SettingsView()
                } else if isPredefinedView {
                    PredefinedView()
                } else {
                    MainTabsView(selectedTab: $selectedTab)
                }
            }
            
            VStack(spacing: 12) {
                if selectedTab == .events && !isSettingsView {
                    Button {
                        isPredefinedView = !isPredefinedView
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(
                                appSettings.useCustomPredefined
                                    ? Color(red: 226 / 255, green: 128 / 255, blue: 128 / 255)
                                    : Color(red: 76 / 255, green: 94 / 255, blue: 139 / 255)
                            )
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 6)
                    }
                }
                
                if !isPredefinedView {
                    Button {
                        isSettingsView = !isSettingsView
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color(red: 76 / 255, green: 94 / 255, blue: 139 / 255))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 6)
                    }
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
    }
}

@available(iOS 13.0, *)
struct MainTabsView: View {
    @Binding var selectedTab: MainTab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                ForEach(MainTab.allCases, id: \.self) { tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        Text(tab.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(selectedTab == tab ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        selectedTab == tab
                                            ? Color(red: 76 / 255, green: 94 / 255, blue: 139 / 255)
                                            : Color.gray.opacity(0.12)
                                    )
                            )
                    }
                }
            }
            .padding()
            
            Group {
                switch selectedTab {
                case .api:
                    ApiView()
                case .events:
                    EventsView()
                case .web:
                    WebView()
                case .store:
                    StoreView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

@available(iOS 13.0, *)
enum MainTab: CaseIterable {
    case api
    case events
    case web
    case store
    
    var title: String {
        switch self {
        case .api:
            return "API"
        case .events:
            return "Events"
        case .web:
            return "Web"
        case .store:
            return "Store"
        }
    }
}


@available(iOS 13.0, *)
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
