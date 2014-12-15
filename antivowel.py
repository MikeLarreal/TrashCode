def anti_vowel(text):
    the_vowel = ["a","e","i","o","u"]
    for index, item in enumerate(text):
        if item.lower() in the_vowel:
            text = text.replace(item, "")
            
    return text    
    
anti_vowel("Hey look Words!")    