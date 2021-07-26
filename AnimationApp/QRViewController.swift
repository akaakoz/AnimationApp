//
//  QRViewController.swift
//  AnimationApp
//
//  Created by Akiya Ozawa on R 3/07/17.
//

import UIKit
import CoreImage.CIFilterBuiltins

class QRViewController: UIViewController {
    
    let context = CIContext()
    
    private let filter = CIFilter.qrCodeGenerator()
    
    var qrImageView = UIImageView()
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        view.addSubview(qrImageView)
        qrImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 50)
        qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        qrImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        guard var url = url else {return}
//        url = "www.akiya.com"
//        print(url)
        qrImageView.image = generateQRCodeImage(url: "www.akiya.com")
    }
    
    func generateQRCodeImage(url: String) -> UIImage {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
            
        }
        
        return UIImage(systemName: "sdgk") ?? UIImage()
    }
}
