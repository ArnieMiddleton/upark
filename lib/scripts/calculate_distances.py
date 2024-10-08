from haversine import haversine
import json

# Define your locations with (latitude, longitude) tuples
building_locations = {
    'Campus Bike Shop': (40.7605798, -111.8428217),
    'S.J. Quinney College of Law': (40.7612208, -111.8514449),
    'Mineral Processing Lab': (40.7665169, -111.8448861),
    'Mining Systems Research Lab': (40.7666465, -111.8445482),
    'Experimental Studies Building': (40.7660466, -111.8447915),
    'John and Marva Warnock Engineering Building': (40.7677074, -111.845305),
    'Alice Sheets Marriott Center for Dance': (40.762399, -111.8485909),
    'Life Science Building': (40.763534, -111.8501393),
    'Chemistry Cooling Tower': (40.7623958, -111.8502781),
    'High Temperature Water Plant': (40.760472, -111.8418901),
    'Recycling Center': (40.760223, -111.8413411),
    'Buildings & Grounds Storage Shed #2': (40.7603222, -111.8403604),
    'Buildings & Grounds Storage Shed #1': (40.7604644, -111.84049),
    'Motor Pool Gas Station': (40.760738, -111.8399211),
    'Motor Pool Building': (40.7605685, -111.8402757),
    'Buildings & Grounds': (40.760374, -111.8406457),
    'Physical Plant Services': (40.7609436, -111.8412124),
    'Public Safety Storage Shed': (40.760029, -111.8408105),
    'George S. Eccles 2002 Legacy Bridge': (40.7649731, -111.8372508),
    'Joseph F. Merrill Engineering Building': (40.7685435, -111.8461438),
    'Floyd and Jeri Meldrum Civil Engineering Building': (40.7670116, -111.8455091),
    'C. Roland Christensen Center': (40.761274, -111.8439109),
    'Sculpture Building': (40.7604263, -111.8446468),
    'Marcia & John Price Museum Building': (40.7602453, -111.843287),
    'Social and Behavioral Science Lecture Hall': (40.7609948, -111.8459596),
    'College of Social Work': (40.7609527, -111.8466878),
    'Questar Gas Shed #1': (40.7630119, -111.8361847),
    'Roy W. & Elizabeth E. Simmons Pioneer Memorial Theatre': (40.7627743, -111.8510771),
    'Office Building 44': (40.7631331, -111.8484522),
    'Aline Wilmot Skaggs Biology Building': (40.7636844, -111.8486777),
    'Alfred C. Emery Building': (40.7641708, -111.8501068),
    'Steam Generating Plant': (40.7656879, -111.8481054),
    'McCarthey Family Track and Field Storage Building': (40.767219, -111.8391541),
    'Golf Pro Shop': (40.7680291, -111.8433072),
    'James LeVoy Sorenson Molecular Biotechnology Building - A USTAR Innovation Center': (40.7689427, -111.8421158),
    'Office of Sponsored Projects': (40.768284, -111.8485698),
    'Fine Arts West': (40.7631906, -111.8528793),
    'Cauldron Legacy Plaza Visitors Center': (40.7588343, -111.8497591),
    'David P. Gardner Hall': (40.7662045, -111.8517317),
    'James Talmage Building': (40.7644381, -111.8495015),
    'Cowles Cooling Tower': (40.7661025, -111.8497673),
    'Beverley Taylor Sorenson Arts & Education Complex': (40.7628492, -111.8415156),
    'HPER Natatorium': (40.7633309, -111.8398826),
    'Skaggs Cooling Tower': (40.7636082, -111.8482286),
    'Building 124': (40.7642739, -111.8491462),
    'Thatcher Building for Biological & Biophysical Chemistry': (40.7617233, -111.849658),
    'Civil and Materials Engineering': (40.766485, -111.8459993),
    'John R. Park Building': (40.7650072, -111.8487908),
    'Intermountain Network Scientific Computation Center':(40.7659168, -111.848729),
    'LeRoy E. Cowles Building': (40.7656173, -111.8495495),
    'Naval Science Building': (40.766645, -111.8493796),
    'Spencer Fox Eccles Business Building':(40.7617223, -111.8433843),
    'Spence Eccles Ski Team Building':(40.7669476, -111.8405543),
    'Grounds Storage Building':(40.7606638, -111.8412352),
    'Salt Lake City Reservoir':(40.7592434, -111.8470646),
    'George S. Eccles Student Life Center':(40.7650827, -111.838233),
    'Pumphouse #3': (40.7626118, -111.8359859),
    'North Campus Chiller Plant':(40.7674303, -111.8427461),
    'Joseph T. Kingsbury Hall': (40.7661964, -111.8509428),
    'Henry Eyring Chemistry Building':(40.7623469, -111.8494898),
    'V. Randall Turpin University Services Building':(40.7613875, -111.8400721),
    'Jon M. Huntsman Center': (40.7620589, -111.8387518),
    'Space Planning & Management': (40.7687097, -111.8486904),
    'Social & Behavioral Sciences':  (40.7614548, -111.8462603),
    'Biology Building':  (40.7635123, -111.8495492),
    'Alan W. Layton Engineering Building':  (40.7665156, -111.84548),
    'Performing Arts Building':  (40.7639132, -111.8479817),
    'Eccles House':  (40.7725992, -111.8437945),
    'Soccer Field Ticket Office':  (40.7673491, -111.8409302),
    'Equipment Shed':  (40.7679182, -111.8417775),
    'Dumke Family Softball Stadium':  (40.7677039, -111.8411626),
    'Field Storage Building':  (40.7681291, -111.8416951),
    'Einar Nielsen Fieldhouse':  (40.7612137, -111.8488777),
    'Transformer Building':  (40.7587237, -111.851231),
    'William Stewart Building':  (40.7634326, -111.8509426),
    'The Gary L. and Ann T. Crocker Science Center at the George Thomas Building':(40.7640556, -111.8511161),
    'HPER West':  (40.762922, -111.8406218),
    'HPER East':  (40.7636929, -111.8391684),
    'Kenneth P. Burbidge, Jr., Family Athletics Academic Center': (40.7629723, -111.8396537),
    'HPER North':  (40.7638422, -111.8403347),
    'HPER Mechanical Building Southwest': (40.7627283, -111.8396291),
    'Central Garage':  (40.7616177, -111.8414221),
    'HTW Plant Cooling Tower':  (40.7607224, -111.8416042),
    'Language & Communication Building':  (40.763612, -111.843649),
    'Bldg 301':  (40.7599051, -111.8410001),
    'Art Building':  (40.7608952, -111.8448774),
    'Architecture Building':  (40.7611435, -111.8445216),
    'A. Ray Olpin Union':  (40.7649585, -111.8460258),
    'Carolyn Tanner Irish Humanities Building':(40.764559, -111.8429781),
    'Student Services Cooling Tower':  (40.7653175, -111.8484318),
    'Student Services Building':  (40.7650099, -111.8480666),
    'James C. Fletcher Building':  (40.7667215, -111.8504586),
    'Physics Maintenance Shed':  (40.7663155, -111.8497409),
    'Voice & Opera Center':  (40.7668481, -111.8518531),
    'Frederick Albert Sutton Building':  (40.7666686, -111.8477967),
    'William C. Browning Building':  (40.7662422, -111.8477118),
    'SW Cooling Tower':  (40.7611313, -111.8480044),
    'John A. Widtsoe Building':  (40.7659103, -111.8501467),
    'J. Willard Marriott Library':  (40.7624564, -111.8462009),
    'Film and Media Arts Building':  (40.7612975, -111.8454004),
    'Business Classroom Building':  (40.7617724, -111.8441455),
    'Pumphouse #8':  (40.76537, -111.8393343),
    'Donna Garff Marriott Residential Scholars Community':(40.7638268, -111.8368582),
    'Cleone Peterson Eccles Alumni House': (40.7658899, -111.8436309),
    'Rosenblatt House':  (40.7714816, -111.845167),
    'Carolyn and Kem Gardner Commons':  (40.7633607, -111.8446581),
    'HPER Mechanical Building Southeast':(40.7629181, -111.8392586),
    'Jon M. and Karen Huntsman Basketball Facility':(40.7630993, -111.8387277),
    'Northwest Garage':  (40.7665208, -111.8487329),
    'Sterling Sill Center':  (40.7653351, -111.8436888),
    'University Campus Store':  (40.7637118, -111.8475237),
    'Physics Cooling Tower':  (40.7665293, -111.8498995),
    'SW Cooling Tower':  (40.7612905, -111.8480052),
    'Physics Building':  (40.7663942, -111.8500583),
    'Meldrum House':  (40.7649572948751, -111.853380680972),
    'Building 72':  (40.7620302, -111.8514106),
    'John & Marcia Price Theatre Arts Building':(40.7620336, -111.8518393),
    'Impact Prosperity Epicenter Building':(40.7653564842492, -111.839022701725),
    'Rio Tinto Kennecott Mechanical Engineering Building':(40.7674748, -111.8477638),
    'Lassonde Studios':  (40.7645445, -111.8415405),
    'Rice-Eccles Stadium':  (40.7600622, -111.8489259),
    'Robert H. and Katharine B. Garff Executive Education Building':(40.7621344, -111.8422519),
    'Dolores Dore Eccles Broadcast Center':(40.7673162, -111.8378598),
    'Kahlert Village':  (40.7637771, -111.837987),
    'Dumke Gymnastics Center':  (40.7643456, -111.8396279),
}

parking_lot_locations = {
    'Parking Lot 1': (40.76047615, -111.8457732),
    'Parking Lot 2': (40.76609893830639, -111.84567689958726),
    'Parking Lot 3': (40.76553734, -111.8475873),
    'Parking Lot 4': (40.75964557, -111.8510534),
    'Parking Lot 5': (40.76184712, -111.8487463),
    'Parking Lot 6': (40.76239342, -111.847587),
    'Parking Lot 7': (40.76021823, -111.8443649),
    'Parking Lot 8': (40.76146288, -111.8381891),
    'Parking Lot 9': (40.76650879, -111.8450367),
    'Parking Lot 10': (40.76343596, -111.8532355),
    'Parking Lot 11': (40.76679045, -111.8514649),
    'Parking Lot 12': (40.76612338, -111.8456363),
    'Parking Lot 13': (40.76545653, -111.8375496),
    'Parking Lot 14': (40.76108824, -111.8425409),
    'Parking Lot 15': (40.75947206, -111.8460659),
    'Parking Lot 16': (40.76183744, -111.850429),
    'Parking Lot 17': (40.77022927, -111.8462263),
    'Parking Lot 18': (40.766834, -111.8437108),
    'Parking Lot 19': (40.76930197, -111.8441186),
    'Parking Lot 20': (40.7678793, -111.8480301),
    'Parking Lot 21': (40.76505561, -111.849477),
    'Parking Lot 22': (40.76164289, -111.8414329),
    'Parking Lot 23': (40.76639168, -111.8487693),
    'Parking Lot 24': (40.76188585, -111.8404306),
    'Parking Lot 25': (40.76307923, -111.8374067),
    'Parking Lot 26': (40.76081929, -111.8395905),
    'Parking Lot 27': (40.7611466, -111.8406582),
    'Parking Lot 28': (40.76748713, -111.8398083),
    'Parking Lot 29': (40.76608434, -111.8494079),
    'Parking Lot 30': (40.765003, -111.8443877),
    'Parking Lot 31': (40.77055754, -111.843232),
    'Parking Lot 32': (40.76906066, -111.8393496),
    'Parking Lot 33': (40.76502741, -111.8421128)
}
distance_data = {}
for building_name, building_coords in building_locations.items():
    distances = {}
    for parking_lot_name, parking_lot_coords in parking_lot_locations.items():
        # Calculate distance in meters, rounded to the nearest meter
        distance = round(haversine(building_coords, parking_lot_coords) * 1000)
        distances[parking_lot_name] = distance

    # Sort the parking lots by distance in ascending order
    sorted_distances = dict(sorted(distances.items(), key=lambda item: item[1]))
    distance_data[building_name] = sorted_distances


# Write the distance data to a JSON file
with open('distances.json', 'w') as outfile:
    json.dump(distance_data, outfile, indent=4)

#write lat and long