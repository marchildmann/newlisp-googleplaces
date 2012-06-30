(context 'GooglePlaces)

;; Attention
;; You need curl installed on Your webserver, because the Google Places API needs secured https and
;; newLISPs (get-url) just works with http

(set 'apikey MAIN:apikey)
(set 'apiurl "https://maps.googleapis.com/maps/api/place")
(set 'language "de")
(set 'sensor "false")
(set 'accuracy nil)
(set 'response-type "xml")
(set 'types "establishment")

;; Place Search	
;; A Place Search request is an HTTP URL of the following form:
;; https://maps.googleapis.com/maps/api/place/search/output?parameters

(define (search-place lat lon radius types)
	(set 'method "search")
	(set 'request (string (append apiurl "/" method "/" response-type 
																		"?location=" lat "," lon
																		"&language=" language
																		"&radius=" radius
																		"&types=" types
																		"&sensor=" sensor
																		"&key=" apikey
								)))
	(CURL:curl-get request)
)

;; Textsearch
;; The Google Places API Text Search Service is a web service that returns information about a set of Places based on a string — for example "pizza in New York" or ;; "shoe stores near ottawa". The service responds with a list of Places matching the text string and any location bias that has been set. The search response will ;; include a list of Places, you can send a Place Details request for more information about any of the Places in the response.
;; https://maps.googleapis.com/maps/api/place/textsearch/xml?query=restaurants+in+Sydney&sensor=true&key=AddYourOwnKeyHere
 
(define (search-text query lat lon radius types)
	(set 'method "textsearch")
	(set 'query (URL:encode-params query))
	(set 'request (string (append apiurl "/" method "/" response-type 
																		"?query=" query
																		"&language=" language
																		"&location=" lat "," lon
																		"&radius=" radius
																		(if-not (= "nil" types) "&types=" types)
																		"&sensor=" sensor
																		"&key=" apikey
								)))
	(CURL:curl-get request)
)

;; Place Check-Ins
;; Once you have a reference from a Place Search request, you can use it to indicate that a user has checked in to that Place.
;; Check-in activity from your application is reflected in the Place search results that are returned - popular establishments 
;; are ranked more highly, making it easy for your users to find likely matches.
;; As check-in activity changes over time, so does the ranking of each Place.

;; POST https://maps.googleapis.com/maps/api/place/check-in/json?sensor=true_or_false&key=AddYourOwnKeyHere HTTP/1.1
;; Host: maps.googleapis.com
;;
;; <CheckInRequest>
;; 		<reference>place_reference</reference>
;; </CheckInRequest>


(define (place-checkin reference)
	(set 'method "check-in")
	(set 'response-type "xml")
	(set 'params (string (append "<CheckInRequest><reference>" reference "</reference></CheckInRequest>")))

	(set 'request (string (append apiurl "/" method "/" response-type 
																		"?sensor=" sensor
																		"&language=" language
																		"&key=" apikey
								)))
	;(println reference)
	;(println request)
	(CURL:curl-post request params)
)

;; Place Details
;; Once you have a reference from a Place Search request, you can request more details about a particular establishment 
;; or point of interest by initiating a Place Details request. A Place Details request returns more comprehensive
;; information about the indicated place such as its complete address, phone number, user rating and reviews.
;;
;; https://maps.googleapis.com/maps/api/place/details/output?parameters
;;

(define (place-details reference sensor)
	(set 'method "details")
	(set 'response-type "xml")
	(set 'request (string (append apiurl "/" method "/" response-type 
																		"?reference=" reference
																		"&sensor=" sensor
																		"&language=" language
																		"&key=" apikey
								)))
	(CURL:curl-get request)
)

;; User Place Reports
;; not implemented yet 2012-06-30
;;

;; END OF FILE