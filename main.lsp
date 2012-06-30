#!/usr/bin/env newlisp

(load "/Users/marc/Desktop/libGooglePlaces.lsp")
(load "/Users/marc/Desktop/libCurl.lsp")
(load "/Users/marc/Desktop/libUrl.lsp")

(set 'radius "5000")
(set 'types "")

;; just some sample cities with latitude / longitude
(new Tree 'CITIES)
(CITIES "hannover" "52.4667,9.68333")
(CITIES "oldenburg" "53.6333,8.21667")
(CITIES "wilhelmshaven" "53.5167,8.13333")
(CITIES "berlin" "52.5,13.35")

(set 'GooglePlaces:apikey "REPLACE-WITH-YOUR-APIKEY")
(set 'GooglePlaces:response-type "xml")
(set 'result (GooglePlaces:search-text "starbucks" (CITIES "hannover") radius types))

(println result)
(exit)