from collections import deque

def reverse(text):
   d = deque()
   d.extendleft(text)
   return ''.join(d)
    