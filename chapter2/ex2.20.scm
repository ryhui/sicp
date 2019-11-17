#lang scheme

(define (same-parity . list)
  (define (helper r list)
    (if (null? list)
        '()
        (if (= (remainder (car list) 2) r)
            (cons (car list) (helper r (cdr list)))
            (helper r (cdr list)))))
  (helper (remainder (car list) 2) list))

; test
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)