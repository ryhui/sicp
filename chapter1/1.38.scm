#lang scheme

(define tolerance 0.00005)

(define (cont-frac n d k)
  (define (helper i)
    (if (equal? i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (helper (+ 1 i))))))
  (helper 1))

(define euler-n (lambda (x) 1))

(define (euler-d x)
  (if (zero? (remainder (+ 1 x) 3))
      (* 2 (/ (+ 1 x) 3))
      1))

(define (euler-res-k k)
  (+ 2.0 (cont-frac euler-n
             euler-d
             k)))

(euler-res-k 10)
(euler-res-k 100)