//
//  SearchViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let session = NetworkSession()
    
    var inputArtistName = ""
    var inputSongTitle = ""
    var lyricsModel: LyricsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        
        let historyButton = UIBarButtonItem(title: "History",
                                            style: .plain,
                                            target: self,
                                            action: #selector(historyButtonTapped))
        navigationItem.rightBarButtonItem = historyButton
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    
        inputArtistName = artistNameTextField.text ?? ""
        guard !inputArtistName.isEmpty else {
            popupError("Please enter artist name")
            return
        }
        
        inputSongTitle = songTitleTextField.text ?? ""
        guard !inputSongTitle.isEmpty else {
            popupError("Please enter song title")
            return
        }
        
        print("input artist: \(inputArtistName)")
        print("input title: \(inputSongTitle)")
    
        search(artistName: inputArtistName, songTitle: inputSongTitle)
    }
    
    // MARK: - Search
    
    private func search(artistName: String, songTitle: String) {
        print(#function)
        
        // Disable Search
        enableSearch(false)
        spinner.startAnimating()
        
        let dataManager = LyricsDataManager(session: session)
        
        Task {
            do {
                lyricsModel = try await dataManager.getLyrics(artist: artistName, title: songTitle)
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
            
            if let lyricsModel = lyricsModel {
                SearchHistoryManager.shared.saveSearchHistory(artistName: artistName,
                                                              songTitle: songTitle,
                                                              lyrics: lyricsModel.lyrics)                
                
                performSegue(withIdentifier: "LyricsSegue", sender: nil)
            }
        }
        
    }
    
    // MARK: - History
    
    @objc func historyButtonTapped() {
        performSegue(withIdentifier: "HistorySegue", sender: nil)
    }
        
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LyricsSegue" {
            let vc = segue.destination as! LyricsViewController
            vc.artistName = inputArtistName
            vc.songTitle = inputSongTitle
            vc.lyrics = lyricsModel?.lyrics ?? "(Lyrics not found)"
        }
    }
    
    // MARK: - Helper Methods
    
    private func enableSearch(_ isEnabled: Bool) {
        artistNameTextField.isEnabled = isEnabled
        songTitleTextField.isEnabled = isEnabled
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
