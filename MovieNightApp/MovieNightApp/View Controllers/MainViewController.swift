//
//  MainViewController.swift
//  MovieNightApp
//
//  Created by Michael Flowers on 1/27/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //keep reference of the users
    var user1: User?
    var user2: User?
    
    @IBOutlet weak var user1PropertiesForButton: UIButton!
    @IBOutlet weak var user2PropertiesForButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        user1 = nil
        user2 = nil
         user1PropertiesForButton.setImage(UIImage(named: "bubble-empty"), for: .normal)
         user2PropertiesForButton.setImage(UIImage(named: "bubble-empty"), for: .normal)
    }
    
    @IBAction func user1ButtonTapped(_ sender: UIButton) {
        //if selected we want to initialize the search view controller - set the storyboard's ID for the nav controller
        let navController = storyboard?.instantiateViewController(withIdentifier: "SearchMovieNavController") as! UINavigationController
        let searchVC = navController.viewControllers.first as! SearchMovieTableViewController
        
        //SearchMovieTableViewController has a delegate protocol and we want to be resonsible/notified when the protocol's function is triggered so we can initialize the users
        searchVC.delegate = self
        
        present(navController, animated: true)
        
    }
    
    @IBAction func user2ButtonTapped(_ sender: UIButton) {
        //if selected we want to initialize the search view controller - set the storyboard's ID for the nav controller
        let navController = storyboard?.instantiateViewController(withIdentifier: "SearchMovieNavController") as! UINavigationController
        let searchVC = navController.viewControllers.first as! SearchMovieTableViewController
        
        //SearchMovieTableViewController has a delegate protocol and we want to be resonsible/notified when the protocol's function is triggered so we can initialize the users
        searchVC.delegate = self
        
        present(navController, animated: true)
    }
    @IBAction func searchButtonTapped(_ sender: Any) {
        //check to see if both users have been initialize or that they hold value
        if let user1 = user1, let user2 = user2 {
            //check to see if each user has selected genres
            guard let user1Genres = user1.selectedGenres, let user2Genres = user2.selectedGenres else {
                //show alert
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            
            //get the matching genre
            let matchingGenres = user1Genres.intersection(user2Genres)
            
            //pass the matching GenreIds to the sortVC
            let sortVC  = storyboard?.instantiateViewController(withIdentifier: "SortMoviesVC") as! SortMovieViewController
            
            let matchingGenreIds = matchingGenres.compactMap { $0.id }
            print("matching genres ids \(matchingGenreIds.count)")
            
            sortVC.selectedIds = matchingGenreIds
            
            present(sortVC, animated: true) {
                self.user1 = nil
                self.user2 = nil
            }
        }
    }

}

extension MainViewController : SearchMovieDelegate {
    
    //use this delegate function to initialize a user with selectedGenres
    func searchMovieViewController(_ searchMovieViewController: SearchMovieTableViewController, didSelectGenres genres: Set<Genre>) {
        if let _ = user1 {
            user2 = User(selectedGenres: genres)
            self.user2PropertiesForButton.setImage(UIImage(named: "bubble-selected"), for: .normal)
        }  else {
            user1 = User(selectedGenres: genres)
             self.user1PropertiesForButton.setImage(UIImage(named: "bubble-selected"), for: .normal)
        }
    }
}
