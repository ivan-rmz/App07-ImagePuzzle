//
//  DropViewDelegate.swift
//  App07-ImagePuzzle
//
//  Created by user205865 on 10/14/21.
//

import SwiftUI

struct DropViewDelegate: DropDelegate{
    
    var image: Img
    var dataModel: DataModel
    @Binding var isCompleted: Bool
    
    func performDrop(info: DropInfo) -> Bool {
        print("caca")
        let fromIndex = dataModel.images.firstIndex { (img) ->Bool in
            return img.id == dataModel.currentImage?.id
        } ?? 0
        let toIndex = dataModel.images.firstIndex { (img) -> Bool in
            return img.id == image.id
        } ?? 0
        
        if fromIndex != toIndex {
            print("from: \(fromIndex) to \(toIndex)")
            
            dataModel.images.swapAt(fromIndex, toIndex)
            if dataModel.currentImage!.id == dataModel.images[toIndex].id {
                if validatePuzzle() {
                    isCompleted = true
                }
            }
        }
        return true
    }
    
    func dropEntered(info: DropInfo) {
        print(image.image)
        print(dataModel.currentImage!.image)
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    private func validatePuzzle() -> Bool{
        
        for index in 0..<dataModel.images.count{
            if dataModel.images[index].id != index{
                return false
            }
        }
        return true
    }
}
