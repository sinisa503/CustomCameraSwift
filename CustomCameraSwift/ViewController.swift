//
//  ViewController.swift
//  CustomCameraSwift
//
//  Created by Sinisa Vukovic on 13/09/16.
//  Copyright © 2016 Sinisa Vukovic. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CustomOverlayDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet var photosCollection: UICollectionView!
    @IBOutlet var addedPhotosLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    var picker = UIImagePickerController()
    var photosArray:[UIImage] = [UIImage]()
    var lblTxt: String {
        get {
            switch photosArray.count {
            case 0: return "No photos added yet..."
            case 1: return "You have added one photo"
            case (let x): return "You have added \(x) photos"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollection.dataSource = self
        photosCollection.delegate = self
        photosCollection.layer.cornerRadius = 3
        submitButton.layer.cornerRadius = 5
        addedPhotosLabel.text = lblTxt
    }
    
    //MARK: - Actions
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
            picker = UIImagePickerController() //make a clean controller
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraViewTransform = CGAffineTransform(scaleX: 1.0, y: 1.70)
            picker.cameraCaptureMode = .photo
            picker.showsCameraControls = false
            picker.delegate = self  //uncomment if you want to take multiple pictures.
            
            
            //customView stuff
            let customViewController = CustomOverlayViewController(nibName:"CustomOverlayViewController",bundle: nil)
            let customView:CustomOverlayView = customViewController.view as! CustomOverlayView
            customView.frame = self.picker.view.frame
            customView.delegate = self
            
            
            //presentation of the camera
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: {self.picker.cameraOverlayView = customView})
        } else { //no camera found -- alert the user.
            let alertVC = UIAlertController(title: "No Camera",message: "Sorry, this device has no camera",
                                            preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            present(
                alertVC,
                animated: true,
                completion: nil)
        }
    }

    //MARK: - Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ImageCell{
            if (photosArray.count > 0){
                let photo = photosArray[indexPath.item]
                cell.uiImage.image = photo
            }
            return cell
        }else {
         return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            if cell.checkimage.isHidden {
                cell.checkimage.isHidden = false
            }else {
                cell.checkimage.isHidden = true
            }
        }
    }
    
    //MARK: Image Picker Controller Delegates
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //get the image from info
        self.photosArray.append(chosenImage)
        photosCollection.reloadData()
        addedPhotosLabel.text = lblTxt
        
        /**Do we want photos to be added to Photos app or no?**/
        //UIImageWriteToSavedPhotosAlbum(chosenImage, self,nil, nil) //save to the photo library
    }

    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
        print("Canceled!!")
    }
    
    //MARK: Custom View Delegates
    func didCancel(_ overlayView:CustomOverlayView) {
        picker.dismiss(animated: true,completion: nil)
        print("dismissed!!")
    }
    func didShoot(_ overlayView:CustomOverlayView) {
        picker.takePicture()
        print("Shot Photo")
    }
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
}


