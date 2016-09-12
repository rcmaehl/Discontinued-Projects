sleep 2.0
espeak -z -v en-german-5 "Welcome back User, it is currently"
date +%l:%M%p | espeak -z -v en-german-5
espeak -z -v en-german-5 "on"
date +%A%B%d | espeak -z -v en-german-5
exit 0
