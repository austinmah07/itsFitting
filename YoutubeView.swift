import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    
    let playlistID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
        let urlString = "https://youtube.com/playlist?list=PLD8ofTnrG0DekJMIitida0zC5Wgk-Ad6S&si=0Pc5usN1gqH6VA9W"
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}

//
//  YoutubeView.swift
//  itsFitting
//
//  Created by Austin Mah on 2026-03-07.
//

