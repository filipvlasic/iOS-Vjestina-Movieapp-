//
//  MovieCategoriesTableViewCell.swift
//  MovieApp
//
//  Created by Filip Vlašić on 01.04.2023..
//

import UIKit
import MovieAppData

class MovieCategoriesTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let cellHeight: CGFloat = 179
    static let cellWidth: CGFloat = 122
    static let cellSpacing: CGFloat = 8
    static let titleColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
  }
  
  static let identifier = String(describing: MovieCategoriesTableViewCell.self)
  private var moviesURL: [URL?]!
  
  private var titleLabel: UILabel!
  private var collectionView: UICollectionView!

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
    addViews()
    styleViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  private func setup() {
    moviesURL = [URL?]()
    
    titleLabel = UILabel()
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(MovieCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MovieCategoriesCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func addViews() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(collectionView)
  }
  
  private func styleViews() {
    titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    titleLabel.textColor = Constants.titleColor
  }
  
  private func setupConstraints() {
    titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
    titleLabel.autoPinEdge(toSuperviewEdge: .top)
    
    collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
    collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), excludingEdge: .top)
    collectionView.autoSetDimension(.height, toSize: Constants.cellHeight)
  }
}

extension MovieCategoriesTableViewCell {
  public func configure(with moviesURL: [URL?], categoryTitle: String) {
    self.moviesURL = moviesURL
    self.titleLabel.text = categoryTitle
  }
}

extension MovieCategoriesTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    moviesURL.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCategoriesCollectionViewCell.identifier, for: indexPath) as? MovieCategoriesCollectionViewCell else { return UICollectionViewCell() }
    
    cell.configure(with: moviesURL[indexPath.row])
    
    return cell
  }
}

extension MovieCategoriesTableViewCell: UICollectionViewDelegate {
  
}


extension MovieCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    Constants.cellSpacing
  }
  
}
