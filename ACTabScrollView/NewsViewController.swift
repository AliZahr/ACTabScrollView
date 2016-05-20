//
//  NewsViewController.swift
//  ACTabScrollView
//
//  Created by AzureChen on 2015/8/19.
//  Copyright (c) 2015年 AzureChen. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ACTabScrollViewDelegate, ACTabScrollViewDataSource {

    @IBOutlet weak var tabScrollView: ACTabScrollView!
    
    let categories = ["Entertainment", "Tech", "Sport", "All", "Travel", "Style", "Features", "Video"]
    var contentViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set ACTabScrollView, all following settings are optional
        tabScrollView.defaultPageIndex = 3
        tabScrollView.arrowIndicator = true
//        tabScrollView.defaultTabSectionHeight = 40
//        tabScrollView.pagingEnabled = true
//        tabScrollView.cachePageLimit = 3
        
        tabScrollView.delegate = self
        tabScrollView.dataSource = self
        
        // create content views
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        for i in 0 ..< categories.count {
            let vc = storyboard.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
            contentViews.append(vc.view)
            vc.headerLabel.text = categories[i] == "All" ? "Today" : "Today's \(categories[i])"
        }
        
        // set navigation bar appearance
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.translucent = false
            navigationBar.tintColor = UIColor.whiteColor()
            navigationBar.barTintColor = UIColor(red: 38.0 / 255, green: 191.0 / 255, blue: 140.0 / 255, alpha: 1)
            navigationBar.titleTextAttributes = NSDictionary(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            navigationBar.shadowImage = UIImage()
        }
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    // MARK: ACTabScrollViewDelegate
    func tabScrollView(tabScrollView: ACTabScrollView, didChangePageTo index: Int) {
        print(index)
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, didScrollPageTo index: Int) {
    }
    
    // MARK: ACTabScrollViewDataSource
    func numberOfPagesInTabScrollView(tabScrollView: ACTabScrollView) -> Int {
        return 8
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, tabViewForPageAtIndex index: Int) -> UIView {
        // create a label
        let label = UILabel()
        label.text = categories[index].uppercaseString
        label.font = UIFont.systemFontOfSize(16, weight: UIFontWeightThin)
        label.textColor = UIColor(red: 77.0 / 255, green: 79.0 / 255, blue: 84.0 / 255, alpha: 1)
        label.textAlignment = .Center
        label.sizeToFit()
        label.frame.size = CGSize(width: label.frame.size.width + 28, height: label.frame.size.height + 36)
        
        return label
    }
    
    func tabScrollView(tabScrollView: ACTabScrollView, contentViewForPageAtIndex index: Int) -> UIView {
        return contentViews[index]
    }
}

