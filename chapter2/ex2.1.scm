#lang scheme

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat n d)
  (let ((n (if (< d 0) (- n) n))
        (d (if (< d 0) (- d) d)))
        (let ((g (gcd n d)))
          (cons (/ n g) (/ d g)))))

; to avoid using letrec, which hasn't been introduced in the book

