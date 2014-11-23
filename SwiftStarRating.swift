//
//  SwiftStarRating.swift
//  Ava2
//
//  Created by Prosper Nwankpa on 11/22/14.
//  Copyright (c) 2014 iProsper. All rights reserved.
//

import UIKit

let kDefaultMaxRating:Float = 5.0
let kDefaultLeftMargin:Float = 5.0
let kDefaultMidMargin:Float = 5.0
let kDefaultRightMargin:Float = 5.0
let kDefaultMinAllowedRating:Float = 1.0
let kDefaultMaxAllowedRating:Float = 5.0
let kDefaultMinStarSize:CGSize = CGSizeMake(5, 5)

class SwiftStarRating: UIView {

    

    
    var _notSelectedStar: UIImage! = UIImage(named:"not_selected_star");
    var _selectedStar: UIImage! = UIImage(named:"selected_star");
    var _halfSelectedStar: UIImage! = UIImage(named:"half_selected_star");
    var _canEdit: Bool  = true;
    var _maxRating: Float = kDefaultMaxRating;
    var _leftMargin: Float = kDefaultLeftMargin;
    var _midMargin: Float = kDefaultMidMargin;
    var _rightMargin: Float = kDefaultRightMargin;
    var _minStarSize: CGSize  = kDefaultMinStarSize;
    var _rating: Float  = kDefaultMinAllowedRating;
    var _minAllowedRating: Float = kDefaultMinAllowedRating;
    var _maxAllowedRating: Float = kDefaultMaxAllowedRating;
    var _starViews: NSMutableArray = NSMutableArray();
    
    
    override init(frame: CGRect)
    {
     
        super.init(frame: frame);
        setupView();
        
    }
    required init(coder: NSCoder)
    {
        
        super.init(coder: coder);
        
        
        
        setupView();
    }
    
    func refreshStars() {
        for(var i:Float = 0; i < Float(_starViews.count); ++i) {
            let imageView: UIImageView = getStarImage(Int(i));
            if (_rating >= i+1) {
                imageView.image = _selectedStar;
            } else if (_rating > i) {
                imageView.image = _halfSelectedStar;
            } else {
                imageView.image = _notSelectedStar;
            }
        }
    }
    
    func setupView() {
        for(var i:Int = 0; i < Int(_maxRating); ++i) {
            //UIImageView *imageView = [[[UIImageView alloc] init] ];
            let imageView: UIImageView = UIImageView()
            imageView.contentMode = .ScaleAspectFit
            _starViews.addObject(imageView);
            self.addSubview(imageView);
        }
        refreshStars();
    }

    override func layoutSubviews() {
        super.layoutSubviews();
        
        //println(@"%f, %f, %f, %d", self.frame.size.width, _leftMargin, _midMargin, _starViews.count);
        let sz = Float(_starViews.count)

        let desiredImageWidth: Float = (Float(self.frame.size.width) - (_leftMargin*2.0) - (_midMargin*sz)) / sz;
        let imageWidth: Float = max(Float(_minStarSize.width), desiredImageWidth);
        let imageHeight: Float = max(Float(_minStarSize.height), Float(self.frame.size.height));
        
        println("laying out subviews")
        for (var i: Int = 0; i < _starViews.count; ++i) {
        println("looping..\(i)")
            let j = Float(i)
            //UIImageView *imageView = [_starViews objectAtIndex:i];
            let imageView: UIImageView = getStarImage(Int(i)); //UIImageView(image: (_starViews.objectAtIndex(i) as UIImage));
            
            let imageFrame = CGRectMake(CGFloat(_leftMargin + j*(_midMargin+imageWidth)), 0, CGFloat(imageWidth), CGFloat(imageHeight));
            imageView.frame = imageFrame;
        
        }
    
    }
    
    
    func setMaxRating(maxRating: Float) {
        if (_maxAllowedRating == _maxRating) {
            _maxAllowedRating = maxRating;
        }
        _maxRating = maxRating;
        
        
        // Remove old image views
        for(var i:Int = 0; i < _starViews.count; ++i) {
            //UIImageView *imageView = (UIImageView *) [_starViews objectAtIndex:i];
            let imageView: UIImageView = getStarImage(Int(i))
            imageView.removeFromSuperview();
        }
        _starViews.removeAllObjects();
        
        // Add new image views
        setupView();
        // Relayout and refresh
        setNeedsLayout();
        refreshStars();
    }
    
    func setRating(rating:Float) {
        _rating = rating;
        refreshStars();
    }

    func handleTouchAtLocation(touchLocation: CGPoint) {
        if (!_canEdit){
            return
        }
        
        _rating = 0;
        for(var i: Int = _starViews.count - 1; i >= 0; i--) {
            //UIImageView *imageView = [_starViews objectAtIndex:i];
            let imageView: UIImageView = getStarImage(i)
            if (touchLocation.x > imageView.frame.origin.x) {
                _rating = Float(i+1);
                break;
            }
        }
        _rating = max(_minAllowedRating, _rating);
        _rating = min(_maxAllowedRating, _rating);
        refreshStars();
    }
    
    func getStarImage(i: Int)->UIImageView{
        return _starViews.objectAtIndex(Int(i)) as UIImageView;
    }
    override func touchesBegan(touches: NSSet, withEvent event:UIEvent) {
        let touch: UITouch = touches.anyObject() as UITouch;
        
        let touchLocation: CGPoint = touch.locationInView(self);
        self.handleTouchAtLocation(touchLocation);
    }

    override func touchesMoved(touches: NSSet, withEvent event:UIEvent) {
    //override func touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint touchLocation = [touch locationInView:self];
//    [self handleTouchAtLocation:touchLocation];
        touchesBegan(touches, withEvent: event)

    }
//    override func touchesEnded(touches: NSSet, withEvent event:UIEvent) {
//    //- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
