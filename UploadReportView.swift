import SwiftUI
import PhotosUI

struct UploadReportView: View {
    let testName: String

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?

    var body: some View {
        VStack(spacing: 20) {

            Text("Upload \(testName) Report")
                .font(.title2)
                .fontWeight(.semibold)

            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                VStack(spacing: 12) {
                    Image(systemName: "doc.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)

                    Text("Select Report Image")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)
            }

            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Upload Report")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedItem) {
            if let item = selectedItem {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        UploadReportView(testName: "Blood Test")
    }
}
