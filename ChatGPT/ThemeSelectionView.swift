import SwiftUI

struct ThemeSelectionView: View {
    @AppStorage("theme") var theme = "Bubbles"
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $theme) {
                    Image("Bubbles" + String(colorScheme == .dark ? "Dark" : "Light"))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .strokeBorder(.gray.opacity(0.5))
                        )
                        .tag("Bubbles")
                    
                    Image("List" + String(colorScheme == .dark ? "Dark" : "Light"))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .strokeBorder(.gray.opacity(0.5))
                        )
                        .tag("List")
                    Image("iMessage" + String(colorScheme == .dark ? "Dark" : "Light"))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .strokeBorder(.gray.opacity(0.5))
                        )
                        .tag("iMessage")
                    Image("FullMoon" + String(colorScheme == .dark ? "Dark" : "Light"))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .strokeBorder(.gray.opacity(0.5))
                        )
                        .tag("FullMoon")
                    
                }
                .animation(.bouncy)
                .padding(25)

                .tabViewStyle(PageTabViewStyle())
                HStack {
                    Text("\(theme)".uppercased())
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .navigationTitle("Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct BubblesPreview: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct ListPreview: View {
    var body: some View {
        VStack {}
    }
}
