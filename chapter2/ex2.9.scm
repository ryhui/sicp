#lang scheme

(define (make-interval a b) (cons a b))

(define (upper-bound i)
  (cdr i))

(define (lower-bound i)
  (car i))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define z (add-interval x y))

#|
following substitution model
(width z)
(width (add-interval x y))
(/ (- (+ (upper-bound x) (upper-bound y)) (+ (lower-bound x) (lower-bound y))) 2)
(/ (+ (- (upper-bound x) (lower-bound x)) (- (upper-bound y) (lower-bound y))) 2)
(+ (/ (- (upper-bound x) (lower-bound x)) 2) (/ (- (upper-bound y) (lower-bound y)) 2))
(+ (width x) (width y))
|#