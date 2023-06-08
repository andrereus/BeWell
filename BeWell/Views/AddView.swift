//
//  AddView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var categoriesData: [Category]
    @Binding var serverOutput: [String: String]
    @Binding var postForm: PostForm
    
    @State var type: String = "quote"
    @State var quote: String = ""
    @State var quoteAuthor: String = ""
    @State var uid: String = ""
    @State var category: String = "1"
    @State var reported: String = "0"
    
    @State var image: Data = Data()
    @State private var pickerData: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Typ")) {
                    Picker(selection: $type, label: Text("Typ")) {
                        Text("Zitat").tag("quote")
                        Text("Bild").tag("image")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if (type == "quote") {
                    Section(header: Text("Zitat")) {
                        TextEditor(text: $quote)
                        TextField("Author", text: $quoteAuthor)
                    }
                } else if (type == "image") {
                    Section(header: Text("Bild")) {
                        PhotosPicker("Bild wählen", selection: $pickerData, matching: .images)
                        
                        if let selectedImage {
                            selectedImage.resizable().scaledToFit()
                        }
                    }.onChange(of: pickerData) { _ in
                        Task {
                            if let data = try? await pickerData?.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                    image = uiImage.jpegData(compressionQuality: 0.2) ?? Data()
                                    
                                    return
                                }
                            }

                            print("Error")
                        }
                    }
                }
                
                Section(header: Text("Kategorie")) {
                    Picker(selection: $category, label: Text("Kategorie")) {
                        ForEach(categoriesData) {
                            Text($0.name).tag($0.id)
                        }
                    }
                }
                
                Button("Veröffentlichen") {
                    addPost()
                }
            }
            .navigationBarTitle("Post hinzufügen", displayMode: .inline)
        }
    }
    
    func addPost() {
        uid = serverOutput["uid"]!
        
        let temp: PostForm = PostForm(type: type, image: image, quote: quote, quoteAuthor: quoteAuthor, uid: uid, category: category, reported: reported)
        postForm = temp
        
        presentation.wrappedValue.dismiss()
    }
}
