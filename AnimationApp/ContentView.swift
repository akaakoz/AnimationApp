//
//  ContentView.swift
//  AnimationApp
//
//  Created by Akiya Ozawa on R 3/06/27.
//

import SwiftUI
import UIKit
import Lottie

class AnimationViewController: UIViewController, CarouselControllerDelegate {
    
    let lottieAssetNameStringArray = [
        "66200-heart-lottie-animation",
        "65759-coffee-pls-dont-approve",
        "66238-car-rent",
        "66384-lightning-lottie-animation",
        "65833-error",
        "65730-cube-shifter-3",
        "65902-hott"]
    
    let animationView = AnimationView(name: "66200-heart-lottie-animation")
    
    let explationLabel: UILabel = {
        let label = UILabel()
        label.text = "Animation will be displayed here."
        label.textColor = .white
        return label
    }()
    
    lazy var carouselController: CarouselController = {
        let carouselController = CarouselController(collectionViewLayout: UICollectionViewFlowLayout())
        carouselController.carouselCountrollerDelegate = self
        return carouselController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = print("view dod load")
        navigationItem.title = "Animation"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupGradientColor()
        setupView()
       
    }
    
    fileprivate func setupGradientColor() {
        
        let topColor = #colorLiteral(red: 0.6353468299, green: 0.8519950509, blue: 0.8385022283, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.4637677073, green: 0.5104475617, blue: 0.9320364594, alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func setupView() {
        
        view.addSubview(explationLabel)
        explationLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        explationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        explationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let carouselControllerView = carouselController.view!
        view.addSubview(carouselControllerView)
        carouselControllerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 15, paddingRight: 0, height: view.frame.height / 8, width: view.frame.width)
    }
    
    func didTapEmoji(for index: Int) {
        
        explationLabel.isHidden = true
        
        let animationView = AnimationView(name: lottieAssetNameStringArray[index])
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        animationView.center = self.view.center
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
         
        view.addSubview(animationView)
        
        animationView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            animationView.removeFromSuperview()
            
        }
    }
    
    
}

class AnimationViewCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Here's the text"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct AnimationIntegratedController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        return UINavigationController(rootViewController: AnimationViewController())
        //return AnimationViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
    
    typealias UIViewControllerType = UIViewController
}

struct ContentView: View {
    var body: some View {
        
        AnimationIntegratedController().edgesIgnoringSafeArea(.all)
//        Text("Hello, world!")
//            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //AnimationIntegratedController()
        ContentView()
    }
}
