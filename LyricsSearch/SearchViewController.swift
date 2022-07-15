//
//  SearchViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let session = NetworkSession()
    
    var lyricsModel: LyricsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        
        search()
        
    }
    
    private func search() {
        print(#function)
        
        let dataManager = LyricsDataManager(session: session)
        
        Task {
            do {
                let artist = "Coldplay"
                let title = "Adventure of a Lifetime"
                lyricsModel = try await dataManager.getLyrics(artist: artist, title: title)
                print("SUCCESS lyricsModel: \(lyricsModel)")
            } catch {
                popupError(error)
                return
            }            
            
            performSegue(withIdentifier: "SearchDetailsSegue", sender: nil)
        }
        
    }
        
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchDetailsSegue" {
            let vc = segue.destination as! LyricsViewController
            vc.lyricsModel = lyricsModel
        }
    }
    
    // MARK: - Helper Methods
    
    private func popupError(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
