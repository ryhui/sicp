#lang scheme

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a. selectors

(define (left-branch my-mobile)
  (car my-mobile))

(define (right-branch my-mobile)
  (cadr my-mobile))

(define (branch-length my-branch)
  (car my-branch))

(define (branch-structure my-branch)
  (cadr my-branch))

; b. total weight

(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((structure (branch-structure branch)))
      (if (list? structure)
          (total-weight structure)
          structure)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; c. balance test

(define (balanced? mobile)
  (define (torque branch)
    (let ((structure (branch-structure branch)))
      (if (list? structure)
          (* (total-weight structure) (branch-length branch))
          (* structure (branch-length branch)))))
  (and (= (torque (left-branch mobile))
          (torque (right-branch mobile)))
       (and (if (list? (branch-structure (left-branch mobile)))
                (balanced? (branch-structure (left-branch mobile)))
                #t)
            (if (list? (branch-structure (right-branch mobile)))
                (balanced? (branch-structure (right-branch mobile)))
                #t))))

; d. only need to change the selectors: cadr -> cdr

; test

(define m (make-mobile (make-branch 10 1.5) (make-branch 5 3)))
(define n (make-mobile (make-branch 10 4) (make-branch 5 (make-mobile (make-branch 2 6) (make-branch 6 2)))))

(total-weight m)
(total-weight n)

(balanced? m)
(balanced? n)