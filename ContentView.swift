import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {

                Spacer()

                // Medical Icon
                Image(systemName: "heart.text.square.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.blue)

                // App Name
                Text("Verixa Health")
                    .font(.system(size: 28, weight: .semibold))

                // Purpose
                Text("Verify medical advice.\nBefore you spend.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Spacer()

                // Navigate to next screen
                NavigationLink {
                    TreatmentTypeView()
                } label: {
                    Text("Verify My Treatment")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)

                // Trust Footer
                Text("Works offline • No data tracking")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 16)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
