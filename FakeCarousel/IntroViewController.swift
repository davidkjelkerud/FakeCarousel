//
//  IntroViewController.swift
//  FakeCarousel
//
//  Created by David Kjelkerud on 8/16/14.
//  Copyright (c) 2014 David Kjelkerud. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tileOneImageView: UIImageView!
    @IBOutlet weak var tileTwoImageView: UIImageView!
    @IBOutlet weak var tileThreeImageView: UIImageView!
    @IBOutlet weak var tileFourImageView: UIImageView!
    @IBOutlet weak var tileFiveImageView: UIImageView!
    @IBOutlet weak var tileSixImageView: UIImageView!
    
    var yOffsets : [Float] = [-285, -240, -415, -408, -480, -500]
    var xOffsets : [Float] = [-30, 75, -66, 10, -200, -15]
    var scales : [Float] = [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [Float] = [-10, -10, 10, 10, 10, -10]
    let scrollHeight: Float = 568
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = backgroundImageView.image.size
        scrollView.delegate = self
        scrollView.sendSubviewToBack(backgroundImageView)
        updateTilePosition()
    }
    
    func convertValue(value: Float, r1Min: Float, r1Max: Float, r2Min: Float, r2Max: Float) -> Float {
        var ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        updateTilePosition()
    }
    
    func updateTilePosition() {
        var offset = Float(self.scrollView.contentOffset.y)
        println("content offset: \(offset)")
        
        var tiles: [UIImageView] = [tileOneImageView, tileTwoImageView, tileThreeImageView, tileFourImageView, tileFiveImageView, tileSixImageView]
        
        for (index, value) in enumerate(tiles) {
            var rotation = convertValue(offset, r1Min: 0, r1Max: self.scrollHeight, r2Min: self.rotations[index], r2Max: 0)

            var tx = convertValue(offset, r1Min: 0, r1Max: self.scrollHeight, r2Min: self.xOffsets[index], r2Max: 0)
            var ty = convertValue(offset, r1Min: 0, r1Max: self.scrollHeight, r2Min: self.yOffsets[index], r2Max: 0)
            var scale = convertValue(offset, r1Min: 0, r1Max: self.scrollHeight, r2Min: self.scales[index], r2Max: 1)
            
            value.transform = CGAffineTransformMakeRotation(CGFloat(Double(rotation) * M_PI/180))
            value.transform = CGAffineTransformTranslate(value.transform, CGFloat(tx), CGFloat(ty))
            value.transform = CGAffineTransformScale(value.transform, CGFloat(scale), CGFloat(scale))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}