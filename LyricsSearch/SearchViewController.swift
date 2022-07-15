//
//  SearchViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let session = NetworkSession()
    
    var lyricsModel: LyricsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    
        guard let inputArtist = artistTextField.text, !inputArtist.isEmpty else {
            popupError("Please enter artist name")
            return
        }
        
        guard let inputTitle = titleTextField.text, !inputTitle.isEmpty else {
            popupError("Please enter song title")
            return
        }
        
        print("input artist: \(inputArtist)")
        print("input title: \(inputTitle)")
    
        search(artist: inputArtist, title: inputTitle)
    }
    
    private func search(artist: String, title: String) {
        print(#function)
        
        // Disable Search
        enableSearch(false)
        spinner.startAnimating()
        
        let dataManager = LyricsDataManager(session: session)
        
        Task {
            do {
                lyricsModel = try await dataManager.getLyrics(artist: artist, title: title)
                print("SUCCESS: \(lyricsModel)")
                
                // Re-enable Search
                enableSearch(true)
                spinner.stopAnimating()
            } catch {
                popupError(error)
                
                // Re-enable Search
                enableSearch(true)
                spinner.stopAnimating()
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
    
    private func enableSearch(_ isEnabled: Bool) {
        artistTextField.isEnabled = isEnabled
        titleTextField.isEnabled = isEnabled
        searchButton.isEnabled = isEnabled
    }
    
    private func popupError(_ error: String) {
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func popupError(_ error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
