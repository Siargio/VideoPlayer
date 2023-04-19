//
//  CompositionCell.swift
//  VideoPlayer
//
//  Created by Sergio on 17.04.23.
//

import UIKit

class CompositionalCell: UICollectionViewCell {

    static let identifier = "CompositionalCell"

    let imageViewBackground: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let imageView: UIImageView = {
        let image = UIImage(systemName: "play.circle")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        layer.cornerRadius = 25
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("ERROR")
    }

    func addSubviews() {
        addSubview(imageViewBackground)
        imageViewBackground.addSubview(imageView)
    }

    func makeConstraints() {
        imageViewBackground.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(35)
        }
    }
}
