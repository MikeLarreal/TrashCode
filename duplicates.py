def remove_duplicates(li):
    dic = {}
    nlist = []
    count = 0
    
    for item in li:
        if str(item) in dic:
            
            dic[str(item)] =  dic[str(item)]+1 
        else:
            dic[str(item)] = 1
                
    for key, value in dic.items():
        if value >= 2:
            nlist.append(int(key))
        elif value < 2:
            nlist.append(int(key))
            
        
    return nlist
        
         