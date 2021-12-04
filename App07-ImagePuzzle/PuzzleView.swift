//
//  ContentView.swift
//  App07-ImagePuzzle
//
//  Created by user205865 on 10/14/21.
//

import SwiftUI
import MobileCoreServices

struct PuzzleView: View {
    @State var dataModel = DataModel()
    @State var isCopmleted = true
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 4)
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                VStack {
                    Button {
                        dataModel.images.shuffle()
                        isCopmleted = false
                    } label: {
                        HStack{
                            Image(systemName: "shuffle")
                                .font(.largeTitle)
                            Text("Shuffle")
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(20)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)

                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(dataModel.images){ image in
                            Image(image.image)
                                .resizable()
                                .frame(width: (geo.size.width-20)/4, height: (geo.size.width-20)/4)
                                .overlay(
                                    
                                    Rectangle()
                                        .stroke(Color.black, lineWidth: isCopmleted ? 0 : 1)
                                )
                                .onDrag {
                                    dataModel.currentImage = image
                                    return NSItemProvider(item: .some(URL(string: image.image)! as NSSecureCoding), typeIdentifier: String(kUTTypeURL))
                                }
                                .onDrop(of: [.url], delegate: DropViewDelegate(image: image, dataModel: dataModel, isCompleted: $isCopmleted))
                        }
                    }
                    .padding(.horizontal, 10)
                    Image(systemName: isCopmleted ? "completed" : "santacruz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/2)
                        .padding(.top, 20)
                }
                .navigationBarTitle("Puzzle")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
