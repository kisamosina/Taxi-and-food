//
//  PhotosViewController.swift
//  Taxi and food
//
//  Created by mac on 12/02/2021.
//  Copyright © 2021 kisamosina. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices


class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    
    private var selectedImages = [UIImage]()
    private var imagePicker = UIImagePickerController()
    
    
    //MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self

   }
        
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
            //        Check and Respond to Camera Authorization Status
            let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
            switch cameraAuthStatus {
            case .notDetermined: requestCameraPermission()
            case .authorized: return
            case .restricted, .denied: alertCameraAccessNeeded()
            
        }

        
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Снять фото или видео", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Медиатека", style: .default, handler: { _ in
            self.openGallaryForPhoto()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func openGallaryForPhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }   else
          {
              let alert  = UIAlertController(title: "Внимание", message: "На устройстве нет камеры", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              self.present(alert, animated: true, completion: nil)
          }

    }
//    Request Camera Permission
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accesGranted in
            guard accesGranted == true else { return }
            
        })
        
    }

//    Alert Camera Access Needed
    
    func alertCameraAccessNeeded() {
        presentAlert()
    }
   
    
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selectedImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        cell.initCell(userPhoto: selectedImages[indexPath.row])
        return cell
        
    }

}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //    Use the Captured Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
        fatalError("Expected a dictionary containing an image, but was provided the following: \(info)") }
        selectedImages.append(selectedImage)
        dismiss(animated: true, completion: nil)
        self.collectionView.reloadData()
        
    }
    
}

extension PhotosViewController: AlertPresentable {
    var alertComponents: AlertComponents {
        let action1 = AlertActionComponent(title: "Разрешить", style: .default, handler: nil)
        let action2 = AlertActionComponent(title: "Запретить", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        })
        let alertComponents = AlertComponents(title: "Приложение \"Taxi and food\" запрашивает доступ к медиатеке", message: "Доступ к медиатеке необходим, чтобы прикрепить файлы для вашего обращения в службу поддержки", actions: [action1, action2 ], completion: nil)
        
        return alertComponents
        
    }
    
    
}



