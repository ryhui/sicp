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

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1 0)
                     (make-vect 0 0)
                     (make-vect 1 1)))

(define (counter180 painter)
  (transform-painter painter
                     (make-vect 1 1)
                     (make-vect 0 1)
                     (make-vect 1 0)))

(define counter270
  (lambda (painter)
    (transform-painter painter
                       (make-vect 0 1)
                       (make-vect 0 0)
                       (make-vect 1 1))))

;test

(define pattern
  (segments->painter
   (list (make-segment (make-vect 0.5 0) (make-vect 1 0.5))
         (make-segment (make-vect 1 0.5) (make-vect 0.8 0)))))

(paint pattern)
(paint (flip-horiz pattern))
(paint (counter180 pattern))
(paint (counter270 pattern))