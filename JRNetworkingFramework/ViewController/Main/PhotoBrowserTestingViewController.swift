//
//  PhotoBrowserTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 20/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class PhotoBrowserTestingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var imageView: UIImageView!
    //MARK: Parameters - Other
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tool.setNavigationBarUncovered(self)
        
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didImageViewTouched:"))
        self.imageView.userInteractionEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init() {
        let nibNameOrNil = String?("PhotoBrowserTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}

//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
extension PhotoBrowserTestingViewController {
    func didImageViewTouched(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "请从下列方式选择图片：", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let actionSheetCancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        actionSheet.addAction(actionSheetCancelAction)
        if self.imageView.image != nil {
        let actionViewPicture: UIAlertAction = UIAlertAction(title: "查看", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction) in
            let photoBrowser: JRPhotoBrowser = JRPhotoBrowser(imageToShow: self.imageView.image!, delegate: self)
            photoBrowser.showOnScreen()
        })
            actionSheet.addAction(actionViewPicture)
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let alertCameraAction = UIAlertAction(title: "相机", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction) in
                let imageViewPicker = UIImagePickerController()
                imageViewPicker.delegate = self
                imageViewPicker.allowsEditing = true
                imageViewPicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imageViewPicker, animated: true, completion: nil)
            })
            actionSheet.addAction(alertCameraAction)
        }
        let alertGalaryAction = UIAlertAction(title: "图片库", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
            let imageViewPicker = UIImagePickerController()
            imageViewPicker.delegate = self
            imageViewPicker.allowsEditing = true
            imageViewPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imageViewPicker, animated: true, completion: nil)
        })
        actionSheet.addAction(alertGalaryAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
extension PhotoBrowserTestingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: {() in
            let image: UIImage? = (info as NSDictionary).objectForKey(UIImagePickerControllerOriginalImage) as? UIImage
            if image != nil {
                self.imageView.image = image
            } else {
                Log.DLog("图片获取失败")
            }
        })
    }
}
extension PhotoBrowserTestingViewController: UINavigationControllerDelegate {
    
}
extension PhotoBrowserTestingViewController: JRPhotoBrowserDelegate {
    func photoBrowser(photoBrowser: JRPhotoBrowser, actionSheetToShow actionSheet: UIAlertController) {
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
}
//MARK: - Class
//MARK: Classes - Other