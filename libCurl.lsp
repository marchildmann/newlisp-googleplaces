(context 'CURL)

(define (curl-get url)
	;; execute curl
	(set 'result (exec (append "curl -s -X GET \"" url "\"")))
	;; We have to join the result, because exec returns a list and we want the raw result
	(set 'result (join result ""))
)

(define (curl-post url params)
	;; execute curl
	(set 'result (exec (append "curl -s -X POST -d \"" (string params) "\"     \"" url "\"")))
)

;; END OF FILE