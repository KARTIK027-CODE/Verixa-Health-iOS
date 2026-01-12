import SwiftUI

struct MedicalTestView: View {
    var body: some View {
        VStack(spacing: 20) {

            Text("Medical Test Verification")
                .font(.title)
                .fontWeight(.bold)

            Text("""
This section helps you understand:
• Why a test is prescribed
• When it is usually required
• When it may be unnecessary
• Common red flags
""")
            .font(.body)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding()

            Spacer()

            NavigationLink {
                TestSelectionView()
            } label: {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
        }
        .padding()
        .navigationTitle("Medical Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MedicalTestView()
    }
}
