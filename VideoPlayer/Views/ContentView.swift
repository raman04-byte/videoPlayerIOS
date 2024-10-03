//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Raman Tank on 03/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var videoManager = VideoManager()
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    ForEach(Query.allCases, id: \.self) {
                        searhQuery in QueryTag(query: searhQuery, isSelected: videoManager.selectedQuery==searhQuery).onTapGesture {
                            videoManager.selectedQuery = searhQuery
                        }
                    }
                }
                ScrollView{
                    if videoManager.videos.isEmpty{
                        ProgressView()
                    }
                    else {
                        LazyVGrid(columns: columns,spacing: 20) {
                            ForEach(
                                videoManager.videos, id: \.id
                            ){
                                video in NavigationLink{
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                    
                                }
                            }
                        }.padding()
                    }
                }.frame(maxWidth: .infinity)
            }
            .background(Color("AccentColor"))
            .navigationBarHidden(true)
        }
        
    }
}

#Preview {
    ContentView()
}
