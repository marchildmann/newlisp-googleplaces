(context 'URL)

(define (encode-params params)
	(replace " " params "+")
	(replace "&" params "%26")
)

;; URL translation of hex codes with dynamic replacement
;; by kosh04 on GitHub

(define (encode url (literal ""))
  (join (map (lambda (c)
               (if (or (regex "[-A-Za-z0-9$_.+!*'(|),]" (char c))
                       (member (char c) literal))
                   (char c)
                 (format "%%%02X" c)))
             ;; 8-bit clean
             (unpack (dup "b" (length url)) url))))

(define (decode url (opt nil))
  (if opt (replace "+" url " "))
  (replace "%([[:xdigit:]]{2})" url (pack "b" (int $1 0 16)) 0))

;; END OF FILE