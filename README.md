# osm-postgis-scripts

These scripts may be used for detecting all kinds of errors in OpenStreetMap data.

1. [detect_untagged_roads.sql] -> detects roads that have no tags at all. These should either be deleted or given proper tags.
2. [roundabouts.sql] -> detects circular roads in OSM that don't have the "junction"="roundabout" tag
3. [conditional_restriction_old_tags.sql] -> detects restriction that still use deprecated tags like "day_on", "day_off", "hour_on", "hour_off", etc.
4. [relations_unusual_members.sql] -> detects OSM restrictions that have more or less than 3 members; the rule is there should be only 3 members, "from", "via" and "to"
5. [similar_name_altname.sql] -> detects streets that have name and alt_name tags really similar, for example name=Johns Road, alt_name=John's Road 

The database I used for testing the script was downloaded from Geofabrik and loaded to the PostgreSQL server using this script: https://github.com/TelenavMapping/useful-postgis-queries/blob/master/scope.bat
