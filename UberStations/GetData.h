//
//  GetData.h
//  JukeBox
//
//  Created by Eric Rosas on 4/16/15.
//  Copyright (c) 2015 EmpireAppDesignz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetData : NSObject
{
    
}
//Top Songs Objects
@property(nonatomic,retain)NSString *songartistStr;
@property(nonatomic,retain)NSString *songtitleStr;
@property(nonatomic,retain)NSString *currently_playingStr;
@property(nonatomic,retain)NSString *callsignStr;
@property(nonatomic,retain) NSString  *station_idInt;

@property(nonatomic,retain)NSString *genreStr;
@property(nonatomic,retain)NSString *artistStr;
@property(nonatomic,retain)NSString *titleStr;
@property (nonatomic,retain)NSString *songstampStr;
@property(nonatomic,retain)NSString *seconds_remainingStr;

@property(nonatomic,retain)NSString *uberurlStr;
@property(nonatomic,retain)NSString *uberurlwebsiteurlStr;


//Station Get Objects
@property(nonatomic,retain)NSString *Station_StationurlStr;
@property(nonatomic,retain)NSString *Station_StationencodingStr;
@property(nonatomic,retain)NSString *Station_station_id;
@property(nonatomic,retain)NSString *Station_websiteurl;
@property(nonatomic,retain)NSString *Station_callsign;


//Talk Shows Objects
@property(nonatomic,retain)NSString *TalkShow_showgenreStr;
@property(nonatomic,retain)NSString *TalkShow_showid;
@property(nonatomic,retain)NSString *TalkShow_showname;
@property(nonatomic,retain)NSString *TalkShow_imageurl;

//Talk Show Get Stream Url Objects
@property(nonatomic,retain)NSString *TalkShow_StreamUrl;
@property(nonatomic,retain)NSString *TalkShow_StreamEncoding;
@property(nonatomic,retain)NSString *TalkShow_StreamCallsign;
@property(nonatomic,retain)NSString *TalkShow_StreamWebsiteurl;

//Near By Objects
@property(nonatomic,retain)NSString *Near_band;
@property(nonatomic,retain)NSString *Near_genre;
@property(nonatomic,retain)NSString *Near_ubergenre;
@property(nonatomic,retain)NSString *Near_language;
@property(nonatomic,retain)NSString *Near_websiteurl;
@property(nonatomic,retain)NSString *Near_imageurl;
@property(nonatomic,retain)NSString *Near_city;
@property(nonatomic,retain)NSString *Near_state;
@property(nonatomic,retain)NSString *Near_country;
@property(nonatomic,retain)NSString *Near_zipcode;
@property(nonatomic,retain)NSString *Near_callsign;
@property(nonatomic,retain)NSString *Near_dial;
@property(nonatomic,retain)NSString *Near_station_id;
@property(nonatomic,retain)NSString *Near_station_image;
@property(nonatomic,retain)NSString *Near_slogan;

@property(nonatomic,retain)NSString *Near_Station_StationurlStr;
@property(nonatomic,retain)NSString *Near_Station_StationencodingStr;
@property(assign)int Near_Station_station_id;
@property(nonatomic,retain)NSString *Near_Station_websiteurl;
@property(nonatomic,retain)NSString *Near_Station_callsign;

//Search Objects
@property(nonatomic,retain)NSString *Search_callsignStr;
@property(nonatomic,retain)NSString *Search_genreStr;
@property(nonatomic,retain)NSString *Search_artistStr;
@property(nonatomic,retain)NSString *Search_titleStr;
@property(nonatomic,retain)NSString *Search_songstampStr;
@property(nonatomic,retain)NSString *Search_seconds_remainingStr;
@property(nonatomic,retain)NSString *Search_station_idStr;

//Detail Search Objects
@property(nonatomic,retain)NSString *DetailSearch_callsignStr;
@property(nonatomic,retain)NSString *DetailSearch_genreStr;
@property(nonatomic,retain)NSString *DetailSearch_artistStr;
@property(nonatomic,retain)NSString *DetailSearch_titleStr;
@property(nonatomic,retain)NSString *DetailSearch_songstampStr;
@property(nonatomic,retain)NSString *DetailSearch_seconds_remainingStr;
@property(nonatomic,retain)NSString *DetailSearch_station_idStr;

//Search Play Station Objects
@property(nonatomic,retain)NSString *Search_Station_StationurlStr;
@property(nonatomic,retain)NSString *Search_Station_StationencodingStr;
@property(nonatomic,retain)NSString *Search_Station_station_id;
@property(nonatomic,retain)NSString *Search_Station_websiteurl;
@property(nonatomic,retain)NSString *Search_Station_callsign;

//Set Object For Suggestions

@property(nonatomic,retain)NSString *Suggestions_songartistStr;
@property(nonatomic,retain)NSString *Suggestions_songtitleStr;
@property(nonatomic,retain)NSString *Suggestions_currently_playingStr;
@property(nonatomic,retain)NSString *Suggestions_callsignStr;
@property(nonatomic,retain) NSString  *Suggestions_station_idInt;

@property(nonatomic,retain)NSString *Suggestions_genreStr;
@property(nonatomic,retain)NSString *Suggestions_artistStr;
@property(nonatomic,retain)NSString *Suggestions_titleStr;
@property (nonatomic,retain)NSString *Suggestions_songstampStr;
@property(nonatomic,retain)NSString *Suggestions_seconds_remainingStr;

@property(nonatomic,retain)NSString *Suggestions_uberurlStr;
@property(nonatomic,retain)NSString *Suggestions_uberurlwebsiteurlStr;
//Set Top Station Objects
/*"callsign":"GotRadio - Disco",
 "genre":"Music, 80's",
 "artist":"Earth Wind And Fire",
 "title":"Sing A Song",
 "songstamp":"2015-05-03 22:46:21",
 "seconds_remaining":262,
 "station_id":"20712"*/
@property(nonatomic,retain)NSString *TopStation_songartistStr;
@property(nonatomic,retain)NSString *TopStation_songtitleStr;
@property(nonatomic,retain)NSString *TopStation_seconds_remaining;
@property(nonatomic,retain)NSString *TopStation_callsignStr;
@property(nonatomic,retain) NSString *TopStation_station_idInt;
@property(nonatomic,retain)NSString *TopStation_genreStr;

//Premimume Station Objects
@property(nonatomic,retain)NSString *Premimume_callsignStr;
@property(nonatomic,retain)NSString *Premimume_genreStr;
@property(nonatomic,retain)NSString *Premimume_songartistStr;
@property(nonatomic,retain)NSString *Premimume_songtitleStr;
@property(nonatomic,retain)NSString *Premimume_SongStatmp;
@property(nonatomic,retain)NSString *Premimume_seconds_remaining;
@property(nonatomic,retain) NSString *Premimume_station_idInt;

//premimume Get Url Objects
@property(nonatomic,retain)NSString *Premimume_Station_StationurlStr;
@property(nonatomic,retain)NSString *Premimume_Station_StationencodingStr;
@property(nonatomic,retain)NSString *Premimume_Station_station_id;
@property(nonatomic,retain)NSString *Premimume_Station_websiteurl;
@property(nonatomic,retain)NSString *Premimume_Station_callsign;


@end
