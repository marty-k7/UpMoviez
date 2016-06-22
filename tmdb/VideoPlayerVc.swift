//
//  VideoPlayerVc.swift
//  tmdb
//
//  Created by Martynas Klastaitis  on 11/05/16.
//  Copyright © 2016 marty.k7. All rights reserved.
//



import UIKit

class VideoPlayerVc: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var playerView: YTPlayerView!
    var videoId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerView.delegate = self;
        self.playerView.loadWithVideoId(videoId)
        
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    func playerView(playerView: YTPlayerView!, didChangeToState state: YTPlayerState) {
        switch (state){
        case YTPlayerState.Playing:
            break
        case YTPlayerState.Paused:
            break
        default:
            break
        }
    }
    //MARK: Delegate method
    
    func playerView(playerView: YTPlayerView!, didChangeToQuality quality: YTPlaybackQuality) {
    }
    
    func playerView(playerView: YTPlayerView!, receivedError error: YTPlayerError) {
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        self.playerView.playVideo()
    }
}
