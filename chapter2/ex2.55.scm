#lang scheme

(car ''abracadabra)

; so the interpreter treats ''abracadabra as a list containing a quote and the word
; from Bill the Lizard: ' is actually shorthand for quote - so '(quote abracadabra)
