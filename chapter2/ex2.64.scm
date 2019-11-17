#lang scheme

(define make-tree list)

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts) right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; partial-tree calculates the size of the left branch and calls recursively on
; itself to build the tree on the left, takes the central element as the entry,
; and again calls recursively on itself to build the remaining elements into a
; tree on the right. Then it makes a tree from entry, left tree and right tree,
; also collecting the remaining elements from the right tree and returns it (it
; is necessary because when building the left-tree, not all elements passed to
; partial-tree will be used in the tree, and we need to preserve them

; (partial-tree (list 1 3 5 7 9 11) 6)
; - (partial-tree (list 1 3) 2)
; - - (partial-tree (list 1) 1)
; - - - (partial-tree '() 0)
; - - - (partial-tree '() 0)
; - - (partial-tree '() 0)
; - (partial-tree (list 7 9 11) 3)
; - - (partial-tree (list 7) 1)
; - - - (partial-tree '() 0)
; - - - (partial-tree '() 0)
; - - (partial-tree (list 11) 1)
; - - - (partial-tree '() 0)
; - - - (partial-tree '() 0)

(list->tree (list 1 3 5 7 9 11))

; The order is log(n)