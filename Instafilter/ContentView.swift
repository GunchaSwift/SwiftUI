//
//  ContentView.swift
//  Instafilter
//
//  Created by Guntars Reiss on 31/08/2022.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        // Step 1: Load our image into a UIImage
        guard let inputImage = UIImage(named: "Example") else { return }
        // Step 2: Convert that into CIImage. CIImage is what Core Image wants to work with.
        let beginImage = CIImage(image: inputImage)
        // Step 3: Create the context and filter
        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        // Step 4: Customize the filter
        currentFilter.inputImage = beginImage
        
        // Test
        // Test
        //
        //
        //
        
        let amount = 1.0
        let inputKeys = currentFilter.inputKeys
    
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        // Step 5: Get a CIImage from our filter
        guard let outputImage = currentFilter.outputImage else { return }
        // Step 6-8: Convert the CIImage back to CGimage, then to UIImage and finally to SwiftUI Image.
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
