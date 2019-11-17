#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect x y)
  (make-vect (+ (xcor-vect x) (xcor-vect y))
             (+ (ycor-vect x) (ycor-vect y))))

(define (sub-vect x y)
  (make-vect (- (xcor-vect x) (xcor-vect y))
             (- (ycor-vect x) (ycor-vect y))))

(define (scale-vect v s)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-below
           (transform-painter painter1
                              (make-vect 0 0)
                              (make-vect 1 0)
                              split-point))
          (paint-up
           (transform-painter painter2
                              split-point
                              (make-vect 1 0.5)
                              (make-vect 0 1))))
      (lambda (frame)
        (paint-below frame)
        (paint-up frame)))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0 0)
                              split-point
                              (make-vect 0 1)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1 0)
                              (make-vect 0.5 1))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below2 painter1 painter2)
    (let ((p1 (rotate90 painter1))
           (p2 (rotate90 painter2)))
       (rotate270 (beside p2 p1))))
  