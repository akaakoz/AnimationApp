//
//  CarouselController.swift
//  AnimationApp
//
//  Created by Akiya Ozawa on R 3/06/27.
//
// feature/add-payment

import UIKit

protocol CarouselControllerDelegate {
    func didTapEmoji(for index: Int)
}
class CarouselController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let carouselCellId = "carouselCellId"
    
    var carouselCountrollerDelegate: CarouselControllerDelegate?
    
    let emojiArray = ["❤️", "☕️", "🚗", "⚡️", "❗️", "🎁", "🔥"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: carouselCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellId, for: indexPath) as! CarouselCell
        cell.emojiLabel.text = emojiArray[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.width / 4)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        carouselCountrollerDelegate?.didTapEmoji(for: indexPath.item)
        
    }
    
}

class CarouselCell: UICollectionViewCell {
    
    let sampleView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return sv
    }()
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "☕️"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sampleView)
        sampleView.layer.cornerRadius = frame.height / 2
        sampleView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        
        sampleView.addSubview(emojiLabel)
        emojiLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        emojiLabel.centerXAnchor.constraint(equalTo: sampleView.centerXAnchor).isActive = true
        emojiLabel.centerYAnchor.constraint(equalTo: sampleView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
