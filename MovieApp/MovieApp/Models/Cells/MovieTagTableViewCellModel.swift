//
//  MovieTagTableViewCellModel.swift
//  MovieApp
//
//  Created by Filip Vlašić on 30.05.2023..
//

import UIKit

struct MovieTagTableViewCellModel: MovieCategoriesCellProtocol {
  var cellType: UITableViewCell.Type = MovieTagTableViewCell.self
  let movieTags: [MovieTag]
}
