//
//  MoviesTableViewController.swift
//  TMDb
//
//  Created by Rodrigo Bueno Tomiosso on 27/02/2018.
//  Copyright © 2018 mourodrigo. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let movieClient = MovieClient()
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerMovieClientObserver()
        self.refreshControl?.addTarget(self, action: #selector(prepareToFetch), for: .valueChanged)
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    // MARK: - Table view data source
    
    @objc func prepareToFetch() {
        self.tableView.refreshControl?.beginRefreshing()
        self.movies.removeAll()
        movieClient.fetchUpcoming()
    }
    
    func registerMovieClientObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("didfetchMovies"),
                                               object: nil,
                                               queue: OperationQueue.main)
        { (notification) in
            
            if let newMovies = notification.object as? [Movie] {
                self.movies.append(contentsOf: newMovies)
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        
        cell.titleTextLabel.text = movie.title
        cell.posterImageView.downloadedFrom(link: ConfigurationClient.sharedInstance.imageBaseURLPath() + "w342" + movie.posterPath)
        
        if let date = movie.releaseDate {
            cell.releaseDateTextLabel.isHidden = false
            cell.releaseDateTextLabel.text = date.toString()
        } else {
            cell.releaseDateTextLabel.isHidden = true
        }
        
        cell.genreTextLabel.isHidden = true
        cell.genreTextLabel.text = ""
        for genreId in movie.genreIds {
            if let genre = GenreClient.sharedInstance.genresList[genreId] {
                cell.genreTextLabel.text = cell.genreTextLabel.text! + genre + "; "
                cell.genreTextLabel.isHidden = false
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > movies.count - 2, !movieClient.isWorking {
            if let searchText = searchBar.text {
                movieClient.fetchSearch(having: searchText, on: movieClient.lastFetchPage+1)
            } else {
                movieClient.fetchMoreUpcoming()
            }
        }
    }
    
    // MARK: - Search bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            self.movies.removeAll()
            self.tableView.reloadData()
            movieClient.fetchSearch(having: searchText)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        movies.removeAll()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
