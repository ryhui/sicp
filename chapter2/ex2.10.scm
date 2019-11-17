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

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (error "Dividing by an interval that spans zero!")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

; test
(define a (make-interval 2 3))
(define b (make-interval 1 2))
(define c (make-interval (- 2) (- 1)))
(define d (make-interval (- 1) 1))
(define e (make-interval (- 3) (- 2)))

(div-interval a b)
(div-interval a c)
(div-interval e c)
(div-interval a d)

