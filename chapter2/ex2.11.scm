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
  (define (sign i)
    (cond [(negative? (upper-bound i)) 0]
          [(positive? (lower-bound i)) 2]
          [#t 1]))
  (let ((sign-x (sign x))
        (sign-y (sign y)))
    (cond [(and (= sign-x 0) (= sign-y 0)) ; both x, y are negative intervals
           (make-interval (* (upper-bound x) (upper-bound y))
                           (* (lower-bound x) (lower-bound y)))]
          [(and (= sign-x 2) (= sign-y 2)) ; both are positive intervals
           (make-interval (* (lower-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y)))]
          ((and (= sign-x 1) (= sign-y 2))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (upper-bound x) (upper-bound y))))
          ((and (= sign-x 2) (= sign-y 1))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y))))
          ((and (= sign-x 0) (= sign-y 2))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (upper-bound x) (lower-bound y))))
          ((and (= sign-x 2) (= sign-y 0))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (lower-bound x) (upper-bound y))))
          ((and (= sign-x 0) (= sign-y 1))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (lower-bound x) (lower-bound y))))
          ((and (= sign-x 1) (= sign-y 0))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (lower-bound x) (lower-bound y))))
          [#t
           (let ((p1 (* (lower-bound x) (lower-bound y)))
                 (p2 (* (lower-bound x) (upper-bound y)))
                 (p3 (* (upper-bound x) (lower-bound y)))
                 (p4 (* (upper-bound x) (upper-bound y))))
             (make-interval (min p2 p3)
                            (max p1 p4)))])))


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

(mul-interval a b)
(mul-interval a c)
(mul-interval e c)
(mul-interval a d)

