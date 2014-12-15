def median(li):
    li = sorted(li)
    last = (int(len(li)))
     
    if len(li) > 0 and len(li) % 2==0:
        index = len(li)/2
        print index, li[index], li[index-1]
        media = li[index] + li[index-1]
        print media
    
        media = media/2.0
      
    
    elif len(li) > 0 and len(li) % 2 != 0:
        index  = len(li)/2
        media  = li[index]
        
    return media    
    
median([6, 8, 12, 2, 23])    