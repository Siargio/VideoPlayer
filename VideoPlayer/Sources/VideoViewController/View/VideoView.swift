//
//  MainView.swift
//  VideoPlayer
//
//  Created by Sergio on 17.04.23.
//

import UIKit
import SnapKit

class MainView: UIView {

    //MARK: - UIElements

    let videoPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.font = .systemFont(ofSize: 24)
        return label
    }()

    lazy var searchButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "magnifyingglass")
        button.setImage(image, for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        button.tintColor = .black
        return button
    }()

    let segmentControl: UISegmentedControl = {
        let items = ["sport", "ocean", "people", "animals", "nature"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        return control
    }()

    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CompositionalCell.self, forCellWithReuseIdentifier: CompositionalCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    //MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup

    func addSubviews() {
        addSubview(videoPlayerLabel)
        addSubview(segmentControl)
        addSubview(searchButton)
        addSubview(collectionView)
    }

    func makeConstraints() {
        videoPlayerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(70)
        }

        segmentControl.snp.makeConstraints {
            $0.top.equalTo(videoPlayerLabel.snp.bottom).offset(25)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.height.equalTo(40)
        }

        searchButton.snp.makeConstraints {
            $0.trailing.equalTo(-20)
            $0.top.equalTo(63)
            $0.height.width.equalTo(40)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(5)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in

            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))

                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                layoutItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 5, leading: 10,
                    bottom: 40, trailing: 5)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1 / 2.8),
                    heightDimension: .fractionalHeight(1 / 1))

                let layoutGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitem: layoutItem , count: 3)

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)

                sectionLayout.contentInsets = NSDirectionalEdgeInsets(
                    top: 10, leading: 5, bottom: 0, trailing: 0)

                sectionLayout.orthogonalScrollingBehavior = .groupPaging

                return sectionLayout
            default:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.166),
                    heightDimension: .fractionalHeight(0.14))

                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                layoutItem.contentInsets = NSDirectionalEdgeInsets(
                    top: 0, leading: 5,
                    bottom: 0, trailing: 5)

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(500))

                let layoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [layoutItem])

                let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)

                sectionLayout.contentInsets = NSDirectionalEdgeInsets(
                    top: 0, leading: 5, bottom: 10, trailing: 10)

                sectionLayout.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

                return sectionLayout
            }
        }
    }
}
