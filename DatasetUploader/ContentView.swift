//
//  ContentView.swift
//  DatasetUploader
//
//  Created by Luke Fernandez on 5/3/21.
//

import Foundation
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var surfaceGrade: Double = 10
    @State private var edgeGrade: Double = 10
    @State private var cornerGrade: Double = 10
    @State private var centeringGrade: Double = 10
    
    @State private var backSurfaceGrade: Double = 10
    @State private var backEdgeGrade: Double = 10
    @State private var backCornerGrade: Double = 10
    @State private var backCenteringGrade: Double = 10
    
    @State private var image = UIImage()
    @State private var isShowPhotoLibrary = false
    
    @State private var backImage = UIImage()
    @State private var isShowPhotoLibraryBack = false
    
    var body: some View {
        
        VStack {
            VStack {
                Spacer()
                Text("Category Evaluation")
                Divider()
                
                HStack {
                Slider(value: $surfaceGrade, in: 1...10)
                Spacer()
                Slider(value: $backSurfaceGrade, in: 1...10)
                }
                
                HStack {
                Text("Front surface grade: \(Int(surfaceGrade))")
                Divider()
                Text("Back surface grade: \(Int(backSurfaceGrade))")
                }
                
                Divider()
                
                HStack {
                    Slider(value: $edgeGrade, in: 1...10)
                    Spacer()
                    Slider(value: $backEdgeGrade, in: 1...10)
                }
                
                HStack {
                    Text("Front edge grade: \(Int(edgeGrade))")
                    Divider()
                    Text("Back edge grade: \(Int(backEdgeGrade))")
                }
                
                Divider()
                
                VStack{
                    
                    HStack {
                        Slider(value: $cornerGrade, in: 1...10)
                        Spacer()
                        Slider(value: $backCornerGrade, in: 1...10)
                    }
                   
                    HStack {
                        Text("Front corner grade: \(Int(cornerGrade))")
                        Divider()
                        Text("Back corner grade: \(Int(backCornerGrade))")
                    }
                    
                    Divider()
                    
                    HStack {
                        Slider(value: $centeringGrade, in: 1...10)
                        Spacer()
                        Slider(value: $backCenteringGrade, in: 1...10)
                    }
                    
                    HStack {
                        Text("Front centering grade: \(Int(centeringGrade))")
                        Divider()
                        Text("Back centering grade: \(Int(backCenteringGrade))")
                    }
                    
                    Divider()
                }
        }
        
            HStack {
                VStack {
            Image(uiImage: self.image)
                .resizable()
                //.scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                    
                    Text("Front")
                        .font(.headline)
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .camera, selectedImage: self.$image)
            }
            }
                
            Divider()
                VStack{
            Image(uiImage: self.backImage)
                .resizable()
                //.scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isShowPhotoLibraryBack = true
            }) {
                HStack {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                    
                    Text("Back")
                        .font(.headline)
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
                
            }
            .sheet(isPresented: $isShowPhotoLibraryBack) {
                ImagePicker(sourceType: .camera, selectedImage: self.$backImage)
            }
                    
                }
 
            }
            Divider()
            Button {
                let surfaceName = "\(Int(surfaceGrade))_surface"
                let edgeName = "\(Int(edgeGrade))_edge"
                let cornerName = "\(Int(cornerGrade))_corner"
                let centeringName = "\(Int(centeringGrade))_centering"
                let frontName = surfaceName + "__" + edgeName + "__" + cornerName + "__" + centeringName
                
                let backSurfaceName = "\(Int(backSurfaceGrade))_surface"
                let backEdgeName = "\(Int(backEdgeGrade))_edge"
                let backCornerName = "\(Int(backCornerGrade))_corner"
                let backCenteringName = "\(Int(backCenteringGrade))_centering"
                
                let backName = backSurfaceName + "__" + backEdgeName + "__" + backCornerName + "__" + backCenteringName
                
                let imgPath = "/var/www/data/grade"

                NotificationBanner.show("Uploading...", 5.0, UIColor.systemBlue)
                myImageUploadRequest(imageToUpload: image, imgKey: frontName, path: imgPath)
                myImageUploadRequest(imageToUpload: backImage, imgKey: backName, path: imgPath, shouldNotify: true)
                
                image = UIImage()
                backImage = UIImage()
                surfaceGrade = 10
                backSurfaceGrade = 10
                edgeGrade = 10
                backEdgeGrade = 10
                cornerGrade = 10
                backCornerGrade = 10
                centeringGrade = 10
                backCenteringGrade = 10
                
            } label: {
                Text("Submit")
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center) 
            }
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,  maxHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.horizontal)
    }
    }
    
}

class NotificationBanner {
  static let labelLeftMarging = CGFloat(16)
  static let labelTopMargin = CGFloat(24)
  static let animateDuration = 1.0
  static var bannerAppearanceDuration: TimeInterval = 2
  
    static func show(_ text: String, _ time: Double, _ color: UIColor) {
    let superView = UIApplication.shared.keyWindow!.rootViewController!.view!
    bannerAppearanceDuration = time
    let height = CGFloat(64)
    let width = superView.bounds.size.width

    let bannerView = UIView(frame: CGRect(x: 0, y: 0-height, width: width, height: height))
    bannerView.layer.opacity = 1
    bannerView.backgroundColor = color
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    
    let label = UILabel(frame: CGRect.zero)
    label.textColor = UIColor.white
    label.numberOfLines = 0
    label.text = text
    label.translatesAutoresizingMaskIntoConstraints = false
    
    bannerView.addSubview(label)
    superView.addSubview(bannerView)
    
    let labelCenterYContstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: bannerView, attribute: .centerY, multiplier: 1, constant: 10)
    let labelCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: bannerView, attribute: .centerX, multiplier: 1, constant: 0)
    let labelWidthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width - labelLeftMarging*2)
    let labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: bannerView, attribute: .top, multiplier: 1, constant: labelTopMargin + 20)
    
    let bannerWidthConstraint = NSLayoutConstraint(item: bannerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
    let bannerCenterXConstraint = NSLayoutConstraint(item: bannerView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
    let bannerTopConstraint = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0-height)
    
    NSLayoutConstraint.activate([labelCenterYContstraint, labelCenterXConstraint, labelWidthConstraint, labelTopConstraint, bannerWidthConstraint, bannerCenterXConstraint, bannerTopConstraint])
    
    UIView.animate(withDuration: animateDuration) {
      bannerTopConstraint.constant = 0
      superView.layoutIfNeeded()
    }
    
    //remove subview after time 2 sec
    UIView.animate(withDuration: animateDuration, delay: bannerAppearanceDuration, options: [], animations: {
      bannerTopConstraint.constant = 0 - bannerView.frame.height
      superView.layoutIfNeeded()
    }, completion: { finished in
      if finished {
        bannerView.removeFromSuperview()
      }
    })
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func myImageUploadRequest(imageToUpload: UIImage, imgKey: String, path: String, shouldNotify: Bool = false) {

    let myUrl = NSURL(string: "http://databox.ddns.net/dataphp.php");
    let request = NSMutableURLRequest(url:myUrl! as URL);
    request.httpMethod = "POST";

    let param = [
        "filePath"    : path
    ]

    let boundary = generateBoundaryString()
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

    let imageData = imageToUpload.jpegData(compressionQuality: 1)
    if imageData == nil  {
        DispatchQueue.main.async {
            if(shouldNotify) { NotificationBanner.show("An error occured for one or both of the photos. Do you have an internet connection? Contact Luke for more info.", 8.0, UIColor.red) }
        }
        return
    }

    request.timeoutInterval = 240
    request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary, imgKey: imgKey) as Data
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

            if error != nil {
                print("error=\(error!)")
                DispatchQueue.main.async {
                    if(shouldNotify) { NotificationBanner.show("An error occured for one or both of the photos. Do you have an internet connection? Contact Luke for more info.", 8.0, UIColor.red) }                }
                return
            }
            

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
        
        let resString: String = responseString! as String
        if !resString.contains("Error") {
            //Success banner msg can be added here async
            
        } else {
            DispatchQueue.main.async {
                if(shouldNotify) { NotificationBanner.show("An error occured for one or both of the photos. Do you have an internet connection? Contact Luke for more info.", 8.0, UIColor.red) }            }
        }
        
        }
        task.resume()
   
       
    
    }




func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String, shouldNotify: Bool = false) -> NSData {
        let body = NSMutableData();

        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }

        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpg"

        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")

        return body
    }

    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }


extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

