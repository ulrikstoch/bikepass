//
//  InfoView.swift
//  BikePass
//
//  Created by Ulrik Stoch Jensen on 11/03/2024.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingShareSheet = false
//    @AppStorage("selectedIconName") var selectedIconName: String = "AppIcon" // Fetching the selected icon name
 
     var body: some View {
             List {
                 Section {
                     ZStack {
                         
                         Image("app_icon_shadow")
                             .padding(.top, 50.0)
                         
                         VStack{
                             Text("BikePass")
                                 .font(.title)
                                 .fontWeight(.bold)
                                 .multilineTextAlignment(.center)
                                 .padding(.bottom, 1.0)
                             
                             
                             Text("Built by Ulrik Stoch Jensen")
                                 .font(.callout)
                                 .multilineTextAlignment(.center)
                                 .padding(.bottom, 10.0)

                             
                             Text("Illustrations and video \nby Copenhagen Bicycles")
                                 .font(.system(size: 14))
                                 .foregroundColor(Color.gray)
                                 .multilineTextAlignment(.center)
                                 .padding(.bottom, 10.0)
                             
                         }
                         .offset(y: 100)
                     }
//                         .frame(width: .infinity, height: 400)
                     .listRowInsets(EdgeInsets(top: -20, leading: -20, bottom: -20, trailing: -20))
                 }
                 .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))

                                    
                 Section {
//                     NavigationLink {
//                         WidgetSettings(model: BadestedModel())
//                     } label: {
//                         HStack {
//                             ZStack{
//                                 Image("swim")
//                             }
//                             .frame(width: 28.0, height: 28.0)
//                             .background(Color.blue)
//                             .cornerRadius(7)
//                             Text("Widget settings")
//                         }
//
//                     }
                     
//                     NavigationLink {
//                         Badevandskvalitet()
//                     } label: {
//                         HStack {
//                             ZStack{
//                                 Image("swim")
//                             }
//                             .frame(width: 28.0, height: 28.0)
//                             .background(Color.blue)
//                             .cornerRadius(7)
//                             Text("Hvad er badevandskvalitet?")
//                         }
//
//                     }

                     NavigationLink {
                         Text("Credits")
                         
                     } label: {
                         HStack {
                             ZStack{
                                 Image("heart")
                             }
                             .frame(width: 28.0, height: 28.0)
                             .background(Color.red)
                             .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                             Text("Tak til")
                         }

                     }
                     
//                     NavigationLink {
//                         IconPickerView()
//                     } label: {
//                         HStack {
//                             ZStack{
//                                 Image("customicon")
//                             }
//                             .frame(width: 28.0, height: 28.0)
//                             .background(Color.blue)
//                             .cornerRadius(7)
//                             Text("Vælg app ikon")
//                         }
//                     }
                     
//                     NavigationLink {
//                         TipJarView()
//                     } label: {
//                         HStack {
//                             ZStack{
//                                 Image("donate")
//                             }
//                             .frame(width: 28.0, height: 28.0)
//                             .background(Color.indigo)
//                             .cornerRadius(7)
//                             Text("Støt udviklingen")
//                         }
//
//                     }
                     
                     HStack {
                         ZStack{
                             Image("star")
                         }
                         .frame(width: 28.0, height: 28.0)
                         .background(Color.orange)
                         .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                          Button(action: {
                                      ReviewHandler.requestReviewManually()
                                  }) {
                                      Text("Bedøm app")
                                          .foregroundColor(Color(.label))
                                  }
                         Spacer()

                     }
                     


                 }
                 
                 
                 
                 Section {
                     HStack {
                         Spacer()
                         VStack(alignment: .center, spacing: 5.0) {
                                  Text("Designet og bygget i København")
                                       .font(.caption)
                                       .foregroundColor(Color.gray)
                                       .padding(.bottom, 2.0)
                                  Text("Version 2.0")
                                       .font(.caption)
                                       .foregroundColor(Color.gray)
                              }
                         
                         Spacer()
                     }
                     
                          .padding(.bottom, 15.0)
                          .padding(.top, 20)
                          .listRowInsets(EdgeInsets(top: -40, leading: -20, bottom: -20, trailing: -20))
                 }
                 
                 .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.secondarySystemBackground))
                 
                 

             }
             .listStyle(InsetGroupedListStyle())
//             .toolbar {
//             ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading) {
//                 Button {
//                     presentationMode.wrappedValue.dismiss()
//                 } label: {
//                     Image(systemName: "xmark")
//                          .resizable()
//    //                          .frame(width: 25, height: 25)
//                     .foregroundColor(.gray)
//                 }
//             }
//         }

                
   }
    
//    var imageForSelectedIcon: Image {
//            switch selectedIconName {
//            case "Icon-Winter":
//                return Image("app_image_winter")
//            case "Icon-Special":
//                return Image("app_image_special")
//            default:
//                return Image("app_image")
//            }
//        }
}

#Preview {
    InfoView()
}
