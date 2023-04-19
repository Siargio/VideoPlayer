//
//  BottomView.swift
//  VideoPlayer
//
//  Created by Sergio on 18.04.23.
//

import UIKit
import SnapKit

class BottomView: UIView {

    //MARK: - UIElements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search video"
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    let searchTextField: UITextField = {
        let texField = UITextField()
        texField.backgroundColor = .white
        texField.placeholder = "Search"
        texField.textAlignment = .center
        texField.borderStyle = .bezel
        return texField
    }()

    private let imageView: UIImageView = {
        let image = UIImage(named: "imageBottomSheet")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.semanticContentAttribute = .unspecified
        return imageView
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()

    private let stackViewAll: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    //MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup

    func addSubviews() {
        addSubview(stackViewAll)
        stackViewAll.addArrangedSubviews([
            titleLabel,
            searchTextField,
            imageView,
            searchButton
        ])
    }

    func makeConstraints() {
        stackViewAll.snp.makeConstraints {
            $0.leading.top.equalTo(20)
            $0.trailing.bottom.equalTo(-20)
        }

        searchButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
