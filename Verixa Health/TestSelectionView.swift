import SwiftUI

struct TestSelectionView: View {
    let tests = [
        "Blood Test",
        "MRI",
        "CT Scan",
        "X-Ray",
        "Thyroid Test"
    ]

    var body: some View {
        List(tests, id: \.self) { test in
            NavigationLink {
                UploadReportView(testName: test)
            } label: {
                Text(test)
                    .font(.headline)
                    .padding(.vertical, 8)
            }
        }
        .navigationTitle("Select Test")
    }
}

#Preview {
    NavigationStack {
        TestSelectionView()
    }
}
