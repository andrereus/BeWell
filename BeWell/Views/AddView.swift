//
//  AddView.swift
//  BeWell
//
//  Created by Student on 02.06.23.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @Binding var categoriesData: [Category]
    @Binding var serverOutput: [String: String]
    @Binding var postForm: PostForm
    
    @State var type: String = "quote"
    @State var pickerData: PhotosPickerItem?
    @State var image: String = ""
    @State var quote: String = ""
    @State var quoteAuthor: String = ""
    @State var uid: String = ""
    @State var category: String = "1"
    @State var reported: String = "0"
    
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
                        // TODO
                        PhotosPicker("Bild wählen", selection: $pickerData, matching: .images)
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
                    // TODO: Funktion erstellen
                    uid = serverOutput["uid"]!
                    
                    let temp: PostForm = PostForm(type: type, image: image, quote: quote, quoteAuthor: quoteAuthor, uid: uid, category: category, reported: reported)
                    
                    postForm = temp
                }
            }
            .navigationBarTitle("Post hinzufügen", displayMode: .inline)
        }
    }
}
