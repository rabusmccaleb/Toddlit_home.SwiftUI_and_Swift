
//
//  StateSingleton.swift
//  TODD 1.0
//
//  Created by Rabus Mccaleb on 2/7/20.
//  Copyright © 2020 Rabus Mccaleb. All rights reserved.
//

import Foundation
import UIKit
import SwiftAudio 
import SwiftUI
//import FirebaseAuth
//import Firebase


class StateSingleton {
    private init(){}
    static var share = StateSingleton()
    
    var StoryRef : String = "noData"//this is used place and show the proper store
    var userId : String = "noData"// this is used for the backend to show the
    var profileNumber = 0 // defualt to zero for dummy data demonstrations, but the purpose of this is for users with multiple profiles under one account
    
    
    /// SizeValues to be called to calculate the width of specific views
    var ScreenSizeWidth = UIScreen.main.bounds.width
    var ScreenSizeHeight = UIScreen.main.bounds.height
    var isContentView : Bool = false
    
    func ReturnWidthInThrids()->CGFloat{
        var WidthInThirds : CGFloat = ScreenSizeWidth / CGFloat(3.3)/// the reason why I choese 3.5 rather than 3 is because there needs to be a gap space between these views and why not use the gap space created by the left over room between views
        return WidthInThirds
    }
    
    var ImmageRefference : String = "102"
    var TitoloRefference : String = "Title"
    var ArtistaRefference : String = "Art Artsy"
    var ArtistaImageRefference : String = "Art Artsy"
    var Summary : String = ""
    func PassingDataBetweenViews(Image : String, Title : String, Artists : String , ArtistaImage : String ){
        self.ImmageRefference = Image
        self.TitoloRefference = Title
        self.ArtistaRefference = Artists
        self.ArtistaImageRefference = ArtistaImage
        
            }
    
    
    var Navigation : Any = Home()
    var NavigationNumber = 0//because the navigation variable
    func NavigationFunction(_ View : Int)-> Any {
        switch View{
            case 0:
                if NavigationNumber != 0{
                    Navigation = Home()
                }
                break
            case 1:
                if NavigationNumber != 1{
                    Navigation = Discovery()
                }
                break
            case 2 :
                if NavigationNumber != 2{
                    Navigation = Search()
                }
                break
            case 3 :
                if NavigationNumber != 3{
                    Navigation = UserSettings()
                }
                break
            default:
                Navigation = Home()
                break
            }
        return Navigation
    }
    
    var HasUsedBefore : Bool?/// for making checking if the user has interacted with this specifc set of content before such that it can check if ther should be or not be function that run to detrmine if there was faved values the user set for this content. This way there won't be any execution of unncessary computing power for new content interaction beyond saving new conent


    /// Data Request functions that take in a stringed location wher to request data fromt the server which is passed from the main view to the major view: All of it's fundemental display needs
    var ImmagineBucketString : String?
    var DiscorsoBucketString : String?
    var MusicheBucketString : String?
    
    let player = AudioPlayer()
    
    func PlayASong(){
       var URL = Bundle.main.path(forResource: "A Rocket Man", ofType: "m4a")
        
        let audioItem = DefaultAudioItem(audioUrl: URL!, sourceType: .file)
        do {
        try player.load(item: audioItem, playWhenReady: true)
            
        }catch let sessionErr{print("session error")/*for catching any optional errors durinf the playing proccess*/}
        var TimerVar = Timer.scheduledTimer(timeInterval: 3.0 , target: self, selector: #selector(PlayAnotherSong), userInfo: nil, repeats: false)
    }
    
    let secondPlayer = AudioPlayer()
    
    @objc func PlayAnotherSong(){
        
        var URL = Bundle.main.path(forResource: "A Rocket Man", ofType: "m4a")
         
         let audioItem = DefaultAudioItem(audioUrl: URL!, sourceType: .file)
         do {
         try secondPlayer.load(item: audioItem, playWhenReady: true)
             
         }catch let sessionErr{print("session error")/*for catching any optional errors durinf the playing proccess*/}
    }
    
    
    var Vocal = AudioPlayer()
    var Music = AudioPlayer()
    
    func PlayVocals(_ VocalsUrl : String?){
        
        if let Vocals = VocalsUrl {
        var URL = Bundle.main.path(forResource: VocalsUrl! , ofType: "m4a")
    
         let audioItem = DefaultAudioItem(audioUrl: URL!, sourceType: .file)
         do {
         try secondPlayer.load(item: audioItem, playWhenReady: true)
             
         }catch let sessionErr{print("session error")}
            
        }else{
            // should return a popup that shows on screen such that the user is notified that there is an error
            print("Vocals-URL-Not-Present")
        }//end of if statement for vocals
    }
    
    
    func PlayerQue(){
        
    }
    
    
    
    func SampleRequest(){
//
//        AF.request("https://codewithchris.com/code/afsample.json").response(completionHandler: { (response)->Void in
//
//            debugPrint(response)
//
//        })
    }
    
    
    
    
    func DataRequestImmagineContent(_ URLStingRequest : String)->[[Int : UIImage]]{
        let ImmagineArrayData : [[Int : UIImage]] = [[Int : UIImage]]()
        //RequestDataFromServer
        //Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return ImmagineArrayData
    }

    func DataRequestDiscorsoContent(_ URLStingRequest : String)->[[Int : String?]]{
        let DiscorsoArrayData : [[Int : String?]] = [[Int : String?]]()
        //RequestDataFromServer
        //Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return DiscorsoArrayData
    }
    func DataRequestMusicheContent(_ URLStingRequest : String)->[[Int : String?]]{
        let MusicheArrayData : [[Int : String?]] = [[Int : String?]]()
        //RequestDataFromServer
        //Convert it to data
        //parse it via forLoop
        //needs an else case in the event that the data has not been pulled propperly
        return MusicheArrayData
    }
    
    
    /// Image Resize To Optimize Memory Vertical long:
    func VLongResizeImageWithBundle(_ ImageBundle : String?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = UIImage(contentsOfFile: Imagefile) else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.width
            var newHeight = UnscaledImageHeight * ( ImageViewHeight / UnscaledImageWidth )
            
            ImageSize = CGSize(width: ImageViewHeight , height: newHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    
    
    
    
    
    
    func VLongResizeAllImageWithImage(_ ImageBundle : UIImage?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = ImageBundle else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.width
            var newHeight = UnscaledImageHeight * ( ImageViewHeight / UnscaledImageWidth )
            
            ImageSize = CGSize(width: ImageViewHeight , height: newHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    
    
    
    
    
    
    
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    /// Image Resize To Optimize Memory Horizontal long:
    
    func HLongResizeImageWithBundle(_ ImageBundle : String?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = UIImage(contentsOfFile: Imagefile) else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
            
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.height
            var newWidth = UnscaledImageWidth * ( ImageViewHeight / UnscaledImageHeight )
            
            ImageSize = CGSize(width: newWidth , height: ImageViewHeight)

            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    

    func HLongResizeAllImageWithImage(_ ImageBundle : UIImage?,_ UIImageViewForSize: UIImageView)-> UIImage{
        let ImageResize = max(UIImageViewForSize.bounds.size.width , UIImageViewForSize.bounds.size.height)/// max size of the image to be set is here such that the image placed in the image view is the same size as the image view
        var ImageSize : CGSize = CGSize(width: UIImageViewForSize.bounds.size.width, height: UIImageViewForSize.bounds.size.height)
        let _ = UIImageViewForSize.bounds.size
        // var ImmaggineName : String = SourceFile
        var ContainerImmage : UIImage = #imageLiteral(resourceName: "errorImage-vector-image-PnG") // image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
        
        if let Imagefile = ImageBundle{
            guard let ImageView = ImageBundle else{
                return #imageLiteral(resourceName: "errorImage-vector-image-PnG")// image literal here but it's damn near tracnsparent becuase it is the transparent Error UIImage
            }
             
            
            // this is to set the image size and width to an appropriate size that gets clipped and scaled properly:
            var UnscaledImageHeight = ImageView.size.height
            var UnscaledImageWidth = ImageView.size.width
            var ImageViewHeight =  UIImageViewForSize.bounds.size.height
            var newWidth = UnscaledImageWidth * ( ImageViewHeight / UnscaledImageHeight )
            
            ImageSize = CGSize(width: newWidth , height: ImageViewHeight)
            
            
            
            let ImageRender = UIGraphicsImageRenderer(size: ImageSize)/// this is the cg size
            ContainerImmage = ImageRender.image{ _ in ImageView.draw(in : CGRect(origin: .zero , size: ImageSize))
                
            }
        }
        
        return ContainerImmage/// this image has a default set to error displaying uiimage becuase it unless changed by the fact that there is an actual uiimage passed into the container image to be displayed
    }
    
    // Font Function For Todd
    func FontType(_ FontNumber : Int , _ FontSize : CGFloat) -> UIFont{
        
        switch FontNumber {
        case 0 :
            return UIFont(name: "ChalkboardSE-Light", size: FontSize)!
        case 1 :
                return UIFont(name: "ChalkboardSE-Regular", size: FontSize)!
        case 2 :
            return UIFont(name: "ChalkboardSE-Bold", size: FontSize)!
        case 3 :
            return UIFont(name: "AvenirNext-Regular", size: FontSize)!
        case 4 :
            return UIFont(name: "AvenirNext-Medium", size: FontSize)!
        case 5 :
            return UIFont(name: "AvenirNext-DemiBold", size: FontSize)!
        case 6 :
            return UIFont(name: "AvenirNext-DemiBoldItalic", size: FontSize)!
        case 7 :
            return UIFont(name: "AvenirNext-Bold", size: FontSize)!
        case 8 :
            return UIFont(name: "AvenirNext-BoldItalic", size: FontSize)!
        case 9 :
            return UIFont(name: "AvenirNext-Heavy", size: FontSize)!
        case 10 :
            return UIFont(name: "AvenirNext-HeavyItalic", size: FontSize)!

        default :
            return UIFont(name: "AvenirNext-DemiBold", size: 12.0)!
            break
        }
        
    }
    

    
    /// Foor checking the tier for being free or subscription
    var FreeSubColorTabShadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    var NoTierSelectionColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    var FreeSubColorTabColor = #colorLiteral(red: 0.9546068311, green: 0.6856242418, blue: 0.1318061948, alpha: 1)
    var IDStringForTierSelection = "Choosing Plan"
    var TierWasSelected : Bool = false//defalted to false
    var SubsciptionTierSelected : Bool = false
    var FreeTierBooleanSelected : Bool = false
    
    var Black : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var SeventyFivePercentBlack : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
    var FiftyPercentBlack : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    var TwentieFivePercentBlack : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)
    
    var white : UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var SeventyFivePercentWhite : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)
    var FiftyPercentWhite : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5292693662)
    var TwentieFivePercentWhite : UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)

    var PaddingFromTheLeadingEdge : CGFloat = CGFloat(20.0)
    var DiscoveryPadding : CGFloat = CGFloat(1.25)
    var ToddMainUIColor = #colorLiteral(red: 1, green: 0.7535114884, blue: 0.1274098158, alpha: 1)
    var ToddMainUIColorShadow = #colorLiteral(red: 0.79, green: 0.5930266667, blue: 0.0948, alpha: 0.87)
    var ToddSecondaryColor = #colorLiteral(red: 0.9546068311, green: 0.6856242418, blue: 0.1318061948, alpha: 1)
    var MainUIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var LoginBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8) //set to 80% because that is what the uidesign is at
    var LoginCapsuleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3990977113) //capsule color is at 15% look at ui design
    var LoginShadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    var ToddBlue = #colorLiteral(red: 0.2572472394, green: 0.5592103004, blue: 1, alpha: 1) // not the actual todd blue but will work for now
    var ToddBlueShadow = #colorLiteral(red: 0.1767706497, green: 0.3286889083, blue: 0.5504511444, alpha: 0.7961597711) // not the actual todd blue but will work for now
    
    var PreviewContentGradient = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5) ///50%
    var PreviewLowerContentGradient = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25) ///50%
    var ProgressoTrackTint = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
    var SummaryFontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5) // 50%
    var SubtitleFontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
    var ShadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.85)

    func ReturnColor(_ colorValue : Int)-> UIColor{
        var MainUIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return MainUIColor
    }
    
    

    
}// end of class brackets
