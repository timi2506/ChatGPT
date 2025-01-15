import SwiftUI

struct SettingsView: View {
    @AppStorage("apiKey") var apiKey = ""
    @State var showAPIkey = false
    @State var fullScreenAPIkeyField = false
    @State var deletedAppSettings = false
    @State var countdownNumber = "3"
    @State var themeSelection = false
    @Environment(\.dismiss) private var dismiss
    @AppStorage("selectedModel") private var selectedModel: String = "gpt-4o-mini"
    @AppStorage("DevMode") var devMode = false
    @AppStorage("customModel") var customModel = ""
    @AppStorage("enableCustomModel") var addCustomModel = false
    let models: [String] = ["gpt-4o", "chatgpt-4o-latest", "gpt-4o-mini"]
    let experimentalModels: [String] = ["o1", "o1-mini", "o1-preview", "gpt-4o-realtime-preview", "gpt-4o-mini-realtime-preview"]

    var currentVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("GPT Settings") {
                        if !fullScreenAPIkeyField {
                            HStack {
                                if showAPIkey {
                                    TextField("API Key", text: $apiKey)
                                    Image(systemName: "eye.slash.fill")
                                        .onTapGesture {
                                            showAPIkey.toggle()
                                        }
                                } else {
                                    SecureField("API Key", text: $apiKey)
                                    Image(systemName: "eye.fill")
                                        .onTapGesture {
                                            showAPIkey.toggle()
                                        }
                                }
                                Image(systemName: "arrow.down.left.and.arrow.up.right.square.fill")
                                    .onTapGesture {
                                        fullScreenAPIkeyField.toggle()
                                    }
                            }
                        }
                        else {
                            TextEditor(text: $apiKey)
                                .frame(minHeight: 175)
                            HStack {
                                Spacer()
                                Text("Disable Fullscreen")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                Image(systemName: "arrow.up.right.and.arrow.down.left.square.fill")
                                    .onTapGesture {
                                        fullScreenAPIkeyField.toggle()
                                    }
                            }
                        }
                        VStack {
                            Picker("Model", selection: $selectedModel) {
                                Section("Custom") {
                                    if customModel == "" {
                                        Text("No custom Model specified")
                                            .foregroundStyle(.gray)
                                            .disabled(true)
                                    }
                                    else {
                                        Button(customModel) {
                                            selectedModel = customModel
                                        }
                                        .tag(customModel)
                                    }
                                }
                                Section("Experimental") {
                                    ForEach(experimentalModels, id: \.self) { model in
                                        Text(model)
                                    }
                                }
                                Section {
                                    ForEach(models, id: \.self) { model in
                                        Text(model)
                                    }
                                }
                            }
                            Text("Please make sure your API Key supports the Model you want to use, otherwise the requests will fail")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Toggle("Add Custom Model", isOn: $addCustomModel)
                            if addCustomModel {
                                TextField("Custom Model", text: $customModel)
                                    .disabled(!addCustomModel)
                                    .animation(.bouncy)
                                Text("When adding a custom Model make sure it works with the https://api.openai.com/v1/chat/completions API Endpoint")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .animation(.bouncy)
                            }
                            
                        }
                        Button("Reset API Key") {
                            apiKey = ""
                        }
                        .foregroundStyle(.red)
                    }

                    Section("App Settings") {
                        Button("Themes") {
                            themeSelection = true
                        }
                        Button("Reset App Data") {
                            let defaults = UserDefaults.standard
                            let dictionary = defaults.dictionaryRepresentation()
                            dictionary.keys.forEach { key in
                                defaults.removeObject(forKey: key)
                            }
                            dismiss()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let alert = UIAlertController(title: "Success!",
                                                              message: "The App will close in 3 Seconds",
                                                              preferredStyle: .alert)
                                
                                // Present the alert
                                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                                    rootViewController.present(alert, animated: true)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    exit(0)
                                }
                            }
                        }
                        
                    }
                }
                .navigationTitle("Settings")
                HStack {
                    Text("Developed with ❤️ by timi2506\nUtilizing the OpenAI API")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("Version \(currentVersion)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .onTapGesture {
                    if apiKey == "can_toggle_dev_mode = true" {
                        // Enables Developer Mode, if you read this, have fun lol!
                        devMode.toggle()
                        dismiss()
                    }
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                )
                .padding(15)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $themeSelection) {
            ThemeSelectionView()
        }
    }
}

