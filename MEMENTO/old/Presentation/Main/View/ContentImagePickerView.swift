////
////  ContentImagePickerView.swift
////  MEMENTO
////
////  Created by 최승원 on 2022/11/02.
////
//import PhotosUI
//
//extension MainViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        
//        
//        dismiss(animated: true, completion: nil)
//        for item in results {
//            item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
//                
//                if let image = image as? UIImage {
//                    print(image)
//                    DispatchQueue.main.async {
//                        self.viewModel.createImageContent(imageContent: image)
//                    }
//                    
//                }
//            }
//        }
//    }
//    
//    
//    func presentPickerView() {
//        var configuration: PHPickerConfiguration = PHPickerConfiguration()
//        configuration.filter = PHPickerFilter.images
//        configuration.selectionLimit = 1
//        
//        var picker: PHPickerViewController = PHPickerViewController(configuration: configuration)
//        
//        picker.delegate = self
//        self.present(picker, animated: true, completion: nil)
//    }
//}
