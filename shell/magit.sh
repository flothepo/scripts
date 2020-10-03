#!/bin/sh

D=$(readlink -f ${1:-.})
emacsclient -ce "(magit \"$D\")" &
disown
