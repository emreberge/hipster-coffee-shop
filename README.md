Hipster Coffee Shop
===================

An iPhone app that crowdsources laptop friendly coffee shops.

Main idea
---------
A problem developers face when traveling or exploring theire own city is to find those great laptop friendly coffee shops. This app makes the user add coffee shop all over the world.
* Only add a coffee shop if it has wifi
* Fill in the wifi password
* FIll in the coffee price
* A rating for the place

Services that can locate vendors
--------------------------------
* Foursquare
* Yelp
* cafekartan.se

### Foursquare

* List Venues
    https://api.foursquare.com/v2/venues/search?ll=LATT,LONG

Features
--------
* Only add a shop if the phone is connected to wifi
* Auto add the wifi password to keychain (is it even possible)?
* Rate the coffee shops higher if someone the user trusts has rated it. For example, the user probably trusts the people he/she is following on Twitter.
* Cache 4^2 on server side, including venues and image urls to the venues. When a request is made to retrieve points at a location retrieve a large amount of surrounding venues.
* Define areas of locations to be able to do batch updates of lots of venues, lets say all stockholm at once.
* In future we may want to throw out foursquare so how to we grow our own database fast?
* To add venues/edit/ add pictures force login with twitter!? (Obs twitter id is not unique it can be changed)
* Only allow adding of cafes when connected to their wifi.
* New entries have to be confirmed by other users. Only confirm if user are attached to specified ssid.
* To get users to crowd source more use a point system.
* Adding venue gives X points iff somebody confirms.
* Confirming gives Y points.
* Use a add based model, where users pay to get rid of adds/ consume points monthly to get rid of adds. Buy points with in app purchase.
* The map filters confirmed unconfirmed venues.
* Give people points for pictures! Store pictures on own database.
* The props has several sections.
* Wifi section:
	* SSID (auto filled!)
	* Speed test, auto speed test or user rates green/red later display green/yellow/red
	* Password or choose open/variable.
* Coffee:
	* Price
	* Rate taste (Good/bad later displayed as Good/avarage/bad)
* Power: Rate as None/a few/ many
* Let people rate + or - for each place. Later give a point that is between 1.0-0.0 basaed on this. (People either like a place or dislike)
* On the map show icons that directly show coffee/wifi/power status of the place. A pin icon that has all info in it.


Planing
-------

![Planing](hipster-coffee-shop/raw/master/planing.jpg)

Authors
-------
This project is created at [#SthlmStartupHack](http://startuplocation.com/hack) by @emreberge and @simlun
