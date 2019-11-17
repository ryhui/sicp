#lang scheme

; generic options with explicit dispatch:
; need to add a set of new functions for each new type introduced

; data-directed style:
; need to add a new condition under each function definition and add the entry to the
; table for each new type introduced

; message-passing style
; need to add a new type constructor (to return a function) for the new data type

; If new types are often added, the message-passing style is preferred
; If new operations are often added, the data-directed style is preferred