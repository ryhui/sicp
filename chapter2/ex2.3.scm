#lang scheme

(define (square x)
  (* x x))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (length-segment segment)
  (sqrt (+ (square (- (x-point (end-segment segment))
                      (x-point (start-segment segment))))
           (square (- (y-point (end-segment segment))
                      (y-point (start-segment segment)))))))
  
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (average a b)
  (/ (+ a b) 2))

(define (rect-perimeter r)
  (* 2 (+ (rect-h r) (rect-w r))))

(define (rect-area r)
  (* (rect-h r) (rect-w r)))

; first representation: define by two sides that touch

(define (make-rect side-a side-b) ; side-a and side-b are segments
  (cons side-a side-b))

(define (rect-h r)
  (length-segment (car r)))

(define (rect-w r)
  (length-segment (cdr r)))

(rect-area (make-rect (make-segment (make-point 1 2) (make-point 1 3))
                      (make-segment (make-point 1 2) (make-point 5 2))))

(rect-perimeter (make-rect (make-segment (make-point 1 2) (make-point 1 3))
                      (make-segment (make-point 1 2) (make-point 5 2))))

; second representation: define by three points

(define (make-rect point-a point-b point-c)
  (cons (cons point-a point-b) point-c))

(define (rect-h r)
  (length-segment (make-segment (car (car r)) (cdr (car r)))))

(define (rect-w r)
  (length-segment (make-segment (cdr (car r)) (cdr r))))

(define rect2 (make-rect (make-point 1 3)
                         (make-point 1 2)
                         (make-point 5 2)))

(rect-area rect2)
(rect-perimeter rect2)