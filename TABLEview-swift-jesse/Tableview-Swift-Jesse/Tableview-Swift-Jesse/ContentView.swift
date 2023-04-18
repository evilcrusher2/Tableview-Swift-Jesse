//
//  ContentView.swift
//  Tableview-Swift-Jesse
//
//  Created by Williams, Jesse on 4/12/23.
//

import SwiftUI
import MapKit
let data = [
    Item(name: "SPONSOR: Thrive Apothecary", webaddress: "https://thrivetx.com/?ref=txcannaco.com", desc: "Thrive Apothecary is a sponsor of TXCANNACO. Visit their website to see their products and schedule an appointment with a medical cannabis doctor today. Use code TXCANNACO for a discount on your next appointment. Veterans first appointments are donated by Thrive. Click the link below to for more information.", lat: 32.75750605282996, long: -97.35474826054455, imageName: "thrive-stacked-website-logo"),
    Item(name: "Despite being popular among voters, marijuana legalization is long overdue in Texas", webaddress: "https://www.vapingpost.com/2023/02/17/despite-being-popular-among-voters-marijuana-legalization-is-long-overdue-in-texas/", desc: "Republican-held Texas is slow to legalize recreational marijuana and regulate it. This is long overdue, as most people in the state support eventual legalization. Click the link below to read more.", lat: 0, long: -0, imageName: "vaping"),
    Item(name: "Legalization, medical, & hemp bills assigned to Texas Senate commitees", webaddress: "https://txcannaco.com/legalization-medical-hemp-bills-assigned-to-texas-senate-committees/", desc: "SB 209 (Legalization), SB 264 (Hemp–Perry) and SJR 22 (Legalization) were referred to Senate committees this week. Several bills were referred to committee this week, but these three...Click the link below to read more.", lat: 0, long: 0, imageName: "billsassigned"),
    Item(name: "U.S. Senate Comittee approves bipartisan marijuana research bill focused on military veterans", webaddress: "https://www.marijuanamoment.net/u-s-senate-committee-approves-bipartisan-marijuana-research-bill-focused-on-military-veterans-with-ptsd-and-pain/?ref=txcannaco.com", desc: "A U.S. Senate committee approved a bipartisan bill on Thursday to promote marijuana research for military veterans—becoming the first piece of standalone cannabis legislation ever to advance through a committee in the chamber. Click the link below to read more.", lat: 0, long: 0, imageName: "ussenate"),
    Item(name: "Police: Vapes with high THC", webaddress: "https://www.cbs19.tv/article/news/local/vapes-with-high-thc-levels-being-found-on-kilgore-isd-campus/501-d80098b6-179d-42b5-b8bc-1d9442442684", desc: "In Texas, the possession of any amount of THC is a felony, according to criminal defense law firm Guest & Gray. Click the link below to read more.", lat: 0, long: 0, imageName: "highschool"),
    Item(name: "Man arrested in East Texas after THC edibles seized in traffic stop", webaddress: "https://www.ketk.com/news/local-news/man-arrested-in-east-texas-after-thc-edibles-seized-in-traffic-stop/", desc: "TEXARKANA, Texas (KETK) – A man was arrested in Texarkana Monday morning after police found what looked like candy but was later found to be a box of THC edibles during a traffic stop on Jarvis Parkway. Click the link below to read more.", lat: 0, long: 0, imageName: "edibles")
   
]
struct Item: Identifiable {
        let id = UUID()
        let name: String
        let webaddress: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.75750605282996, longitude: -97.35474826054455), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.desc)
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                   Image(systemName: "mappin.circle.fill")
                                       .foregroundColor(.red)
                                       .font(.title)
                                       .overlay(
                                           Text(item.name)
                                               .font(.subheadline)
                                               .foregroundColor(.black)
                                               .fixedSize(horizontal: true, vertical: false)
                                               .offset(y: 25)
                                       )
                               }
                           }
                           .frame(height: 300)
                           .padding(.bottom, -30)
                           
            }
            .listStyle(PlainListStyle())
            .navigationTitle("TXCANNACO IG LINKS")
        }
    }
}
struct DetailView: View {
    @State private var region: MKCoordinateRegion
    
    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
    }
    
    let item: Item
    
    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200)
            Text("Description: \(item.desc)")
                .font(.subheadline)
                .padding(10)
            
            if let url = URL(string: item.webaddress) {
                Link(destination: url) {
                    Text("Link: \(item.webaddress)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .lineLimit(2)
                }
            } else {
                Text("Link: \(item.webaddress)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        
            .navigationBarTitle(item.name, displayMode: .inline)
        
                        
        
        if item.lat != 0 && item.long != 0 { // Only show the map if lat and long are not zero
            Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
            
            .frame(height: 300)
            .padding(.bottom, -30)
        }
        else {
                        Image("txcannaco") // Show a specific image if lat and long are zero
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                            .padding(.bottom, 10)
                    }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
