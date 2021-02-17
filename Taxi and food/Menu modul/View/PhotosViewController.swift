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

//protocol PhotosViewProtocol {
//        var interactor: PhotosInteractorProtocol! { get set }
//}


class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    
    private var selectedImages: [UIImage] = []
    private var imagePicker = UIImagePickerController()

    var counter = 0
    
    //MARK: - IBOutlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var selectImgeLabel: UILabel!
    @IBOutlet var countPicturesLabel: UILabel!
    @IBOutlet var selectImageButton: ServiceRoundAddButton!
    @IBOutlet var sendButton: NextButton!
    @IBOutlet weak var uploadImageView: UploadImageView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        setUpLabelAndButtonText()
        enableSendButtonAndlLabel()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        Check and Respond to Camera Authorization Status
        let cameraAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthStatus {
        case .notDetermined: requestCameraPermission()
        case .authorized: return
        case .restricted, .denied: alertCameraAccessNeeded()
            
        @unknown default:
            break
        }
        
        enableSendButtonAndlLabel()
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Снять фото или видео", style: .default, handler: { _ in
            self.openCamera()
        })
        
        let img1 = UIImage(named: "Camera")
        cameraAction.setValue(img1, forKey: "image")
        alert.addAction(cameraAction)
        
        let galleryAction = UIAlertAction(title: "Медиатека", style: .default, handler: { _ in
            self.openGallaryForPhoto()
        })
        let img2 = UIImage(named: "Gallery")
        galleryAction.setValue(img2, forKey: "image")
        alert.addAction(galleryAction)
        
        
        alert.addAction(UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func senfButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Methods
    
    private func setUpLabelAndButtonText() {
        self.selectImgeLabel.text = PhotosViewControllerTextData.selectImgeLabelText
        self.countPicturesLabel.text = ""
        self.countPicturesLabel.numberOfLines = 1
        self.sendButton.setTitle(CustomButtonsTitles.nextButtonTitle, for: .normal)
    }
    
    //Activating next button
    private func enableSendButtonAndlLabel() {
        if self.counter <= 10{
        self.sendButton.setActive()
        } else {
            self.sendButton.setInActive()
            self.countPicturesLabel.text = PhotosViewControllerTextData.countImagesText
           
        }
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
        if selectedImages.count < 10  {
            selectedImages.append(selectedImage)
            self.counter += 1
        } else {
            self.countPicturesLabel.text = PhotosViewControllerTextData.countImagesText
        }
        
        
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



