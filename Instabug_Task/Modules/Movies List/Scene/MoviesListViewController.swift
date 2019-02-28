//
//  MoviesListViewController.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/23/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableMovies: UITableView!
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var indicatorVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadMoviesIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    private var moviesSection = [MoviesListSection]()
    private var presenter: MoviesListPresenter?
    
    //MARK: - Constants
    private let cellNib = "MovieCell"
    private let cellId = "MovieCellId"
    private let showingIndicatorConstant: CGFloat = -40
    private let hidingIndicatorConstant: CGFloat = 10
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMoviesTableView()
        configureSubViews()
        configureViewModel()
        presenter = MoviesListPresenter(scene: self)
        presenter?.fetchMovies()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Configurations
    func configureMoviesTableView() {
        
        tableMovies.register(UINib(nibName: cellNib, bundle: nil), forCellReuseIdentifier: cellId)
        
        tableMovies.tableFooterView = UIView()
        
        tableMovies.estimatedRowHeight = tableMovies.frame.size.height
        tableMovies.rowHeight = UITableViewAutomaticDimension

    }
    
    func configureSubViews() {
        
        plusImageView.image = plusImageView.image?.withRenderingMode(.alwaysTemplate)
        plusImageView.tintColor = .white
        
    }
    
    func configureViewModel() {
        
        moviesSection.append(MoviesListSection(title: "My Movies", movies: []))
        moviesSection.append(MoviesListSection(title: "All Movies", movies: []))
    }
    
    //MARK: - Actions
    @IBAction func addMovie(_ sender: UIButton) {
        
        presenter?.addNewMovieAction()
    }
    
}

//MARK: - TableViewDelegate & TableViewDatasource
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesSection[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MovieCell
        
        let movie = moviesSection[indexPath.section].movies[indexPath.row]
        cell.configureCell(with: movie)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return moviesSection.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title: String? = nil
        if moviesSection[section].movies.count > 0 {
            
            title = moviesSection[section].title
        }
        return title
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            tableMovies.isScrollEnabled = false
            print("View Loading more movies.... ")
            presenter?.loadMoreMovies()
        }
    }
    
}

//MARK: - MoviesListViewProtocol
protocol MoviesListViewProtocol: AnyObject {
    
    func moviesDidLoadSuccefully(with movies: [MovieViewModel])
    func movieOfMineDidSaveSuccefully(_ movie: MovieViewModel)
    func push(viewController controller: UIViewController)
    func startLoadingMovies()
    func startLoadingMoreMovies()
    func loadMoviesDidFinish()
    func loadingMoviesDidFail(with errorMsg: String)
}

extension MoviesListViewController: MoviesListViewProtocol {
    
    func moviesDidLoadSuccefully(with movies: [MovieViewModel]) {
        
        moviesSection[1].movies = movies
        tableMovies.reloadData()
    }
    
    func movieOfMineDidSaveSuccefully(_ movie: MovieViewModel) {
        
        moviesSection[0].movies.append(movie)
        tableMovies.reloadData()
    }
    
    func push(viewController controller: UIViewController) {
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func startLoadingMoreMovies() {
        
        indicatorVerticalSpaceConstraint.constant = showingIndicatorConstant
        loadMoreIndicator.startAnimating()
    }
    
    func startLoadingMovies() {
        loadMoviesIndicator.startAnimating()
    }
    
    func loadMoviesDidFinish() {
        
        tableMovies.isScrollEnabled = true
        indicatorVerticalSpaceConstraint.constant = hidingIndicatorConstant
        loadMoreIndicator.stopAnimating()
        loadMoviesIndicator.stopAnimating()
    }
    
    func loadingMoviesDidFail(with errorMsg: String) {
        
        let alert = UIAlertController(title: nil, message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
