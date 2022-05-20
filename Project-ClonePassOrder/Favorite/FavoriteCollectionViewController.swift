//
//  FavoriteViewController.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/13.
//

import UIKit

class FavoriteViewController: UICollectionViewController {

    //MARK: - 프로퍼티
    private var 임시카운트 = 0
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "검색결과없음이미지")
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    //MARK: - 라이프사이클
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAtrribute()
        naviSetAttribute()
    }
    init() {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0:
                let item = NSCollectionLayoutItem(
                   layoutSize: .init(widthDimension: .fractionalWidth(1),
                                     heightDimension: .fractionalHeight(1))
                )
                let group = NSCollectionLayoutGroup.horizontal(
                   layoutSize: .init(widthDimension: .fractionalWidth(1),
                                     heightDimension: .absolute(90)),
                   subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 20, leading: 10, bottom: 50, trailing: 10
                )
                return section
            default:
                return NSCollectionLayoutSection.sortLayout(
                    supplementaryItem: .init(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .estimated(100)
                        ),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .topLeading
                    )
                )
            }
        }
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    private func setAtrribute() {
        collectionView.register(
            SortCell.self,
            forCellWithReuseIdentifier: SortCell.identifier
        )
        collectionView.register(
            SecondADCell.self,
            forCellWithReuseIdentifier: SecondADCell.identifier
        )
        collectionView.register(
            FavoriteHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FavoriteHeader.identifier
        )
    }
    private func naviSetAttribute() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "자주가요"
    }
    
    //MARK: - 컬렉션뷰 데이터소스
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SecondADCell.identifier,
                for: indexPath
            )
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SortCell.identifier,
                for: indexPath
            )
            return cell
        }
    }
    override func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String
        , at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FavoriteHeader.identifier,
            for: indexPath
        ) as! FavoriteHeader
        return header
    }
}
