import SwiftUI
import PhotosUI
import Vision

struct UploadReportView: View {

    let testName: String

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var uiImage: UIImage?

    @State private var extractedText: String = ""
    @State private var structuredResults: [MedicalTestResult] = []

    @State private var isProcessing: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - Title
                Text("Upload \(testName) Report")
                    .font(.title2)
                    .fontWeight(.semibold)

                // MARK: - Image Picker
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    VStack(spacing: 12) {
                        Image(systemName: "doc.text.fill")
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

                // MARK: - Selected Image Preview
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .cornerRadius(12)
                }

                // MARK: - OCR Progress
                if isProcessing {
                    ProgressView("Analyzing report…")
                        .padding(.top)
                }

                // MARK: - Structured Results
                if !structuredResults.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {

                        Text("Detected Values")
                            .font(.headline)

                        ForEach(structuredResults) { result in
                            HStack {
                                Text(result.name)
                                    .fontWeight(.medium)

                                Spacer()

                                Text("\(result.value) \(result.unit)")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }

                        // MARK: - Navigate to Explanation
                        NavigationLink {
                            ExplainResultView(results: structuredResults)
                        } label: {
                            Text("Understand My Report")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                        }
                        .padding(.top, 8)
                    }
                }

                // MARK: - Raw OCR Text (DEV ONLY)
                if !extractedText.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Raw Extracted Text")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(extractedText)
                            .font(.footnote)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Upload Report")
        .navigationBarTitleDisplayMode(.inline)

        // MARK: - iOS 17 Safe onChange
        .onChange(of: selectedItem) {
            guard let newItem = selectedItem else { return }

            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {

                    uiImage = image
                    selectedImage = Image(uiImage: image)
                    recognizeText(from: image)
                }
            }
        }
    }

    // MARK: - On-Device OCR (Vision)

    private func recognizeText(from image: UIImage) {
        isProcessing = true
        extractedText = ""
        structuredResults = []

        guard let cgImage = image.cgImage else {
            isProcessing = false
            return
        }

        let request = VNRecognizeTextRequest { request, _ in
            DispatchQueue.main.async {
                self.isProcessing = false

                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    return
                }

                let text = observations
                    .compactMap { $0.topCandidates(1).first?.string }
                    .joined(separator: "\n")

                self.extractedText = text

                // ✅ STRUCTURE STEP (Patient Empowerment)
                self.structuredResults = ReportParser.parse(text: text)
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}

#Preview {
    NavigationStack {
        UploadReportView(testName: "Blood Test")
    }
}
