//
//  StoreDetailStoryView.swift
//  Project-ClonePassOrder
//
//  Created by Eunsoo KIM on 2022/05/17.
//

import UIKit

class StoreDetailStoryView: UIView {
    let storyCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewFlowLayout
        )
        collectionView.backgroundColor = .red
        collectionView.isScrollEnabled = false
        collectionView.register(
            StoryCollectionViewCell.classForCoder(),
            forCellWithReuseIdentifier: "cellID"
        )
        return collectionView
    }()
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
        setAtrribute()
        setLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - setAtrribute
    
    private func setAtrribute() {
    }
    
    // MARK: - setLayout
    
    private func setLayout() {
        self.backgroundColor = .yellow
        self.addSubview(storyCollectionView)
        storyCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(1200)
            make.bottom.equalToSuperview().offset(100)
        }
    }
    func setDelegate() {
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension StoreDetailStoryView:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        collectionView.reloadData()
        return 4
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let dequeueReusableCell = storyCollectionView.dequeueReusableCell(
            withReuseIdentifier: "cellID",
            for: indexPath
        )
        guard let cell =  dequeueReusableCell as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let w = self.frame.width
        return CGSize(width: w, height: 300)
    }
}
