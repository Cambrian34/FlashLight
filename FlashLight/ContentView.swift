//
//  ContentView.swift
//  FlashLight
//
//  Created by Alistair Chambers on 12/15/23.
//

import SwiftUI
import AVFoundation


struct ContentView: View {
    @State var lightOn = false;
    
        var body: some View {
        
        ZStack {
            Color(self.lightOn ? .white : .black)
                            .ignoresSafeArea()

            VStack {
                //Text("Hello, world!")
                
                Button(action: {
                    self.lightOn.toggle()
                    self.toggleTorch()
                }) {
                    Text(self.lightOn ? "Dark":"Light")
                    
                    
                }
            }
           
        }
        .padding()
    }
    func toggleTorch() {
            guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }

            if device.hasTorch {
                do {
                    try device.lockForConfiguration()

                    if device.torchMode == .on {
                        device.torchMode = .off
                    } else {
                        try device.setTorchModeOn(level: 1.0)
                    }

                    device.unlockForConfiguration()
                } catch {
                    print("Error toggling torch: \(error.localizedDescription)")
                }
            }
        }
}

#Preview {
    ContentView()
}



