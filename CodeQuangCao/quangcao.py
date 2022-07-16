#!/usr/bin/python

import os
import pygame
import time
import pyrebase
config = {
    "apiKey": "AIzaSyATfhIehc5XZThp6Z3Mc4xeeZzfgy33Iks",
    "authDomain": "doantn-e31d0-default-rtdb.firebaseio.com",
    "databaseURL": "https://doantn-e31d0-default-rtdb.firebaseio.com",
    "storageBucket": "doantn-e31d0",
}
##################
firebase=pyrebase.initialize_app(config)
db=firebase.database()
timelep=db.child("Time").get().val()
##################

def FindImageFilename(lis):
    for filename in os.listdir("."):
        if filename.lower().endswith(".bmp") : lis.append(filename)
        if filename.lower().endswith(".gif") : lis.append(filename)
        if filename.lower().endswith(".jpg") : lis.append(filename)
        if filename.lower().endswith(".png") : lis.append(filename)
    return ""

def FindDisplayDriver():
    for driver in ["fbcon", "directfb", "svgalib"]:
        if not os.getenv("SDL_VIDEODRIVER"):
            os.putenv("SDL_VIDEODRIVER", driver)
        try:
            pygame.display.init()
            return True
        except pygame.error:
            pass
    return False

class xulyanh():
    def __init__(self) -> None:
        self.width  = pygame.display.Info().current_w
        self.height = pygame.display.Info().current_h
        self.screen = pygame.display.set_mode((self.width,self.height), pygame.FULLSCREEN)
        pygame.mouse.set_visible(False)
    def capnhathinhanh(self,a):
        image = pygame.image.load(a)
        if True:
            image = pygame.transform.scale(image, (self.width,self.height))
        self.screen.blit(image,(0,0))
        pygame.display.update()
        return 0           
def Main():
    a=list()
    FindImageFilename(a)
    if not a:
            print("No image file found")
    else:
        pygame.init()
        if not FindDisplayDriver():
            print("Failed to initialise display driver")
        else:
            hinhnen=xulyanh()
            i=0
            
            while db.child("/TramPhat1/Condition").get().val():
                for j in range(0,timelep):
                    if db.child("/TramPhat1/Reboot").get().val():
                        db.update({"/TramPhat1/Reboot":False})
                        os.system('reboot')
                    if not db.child("/TramPhat1/Condition").get().val():
                        break
                    if db.child("/TramPhat1/Next").get().val():
                        i=i+1
                        if(i==len(a)):
                            i=0
                        db.update({"/TramPhat1/Next":False})
                        j=0
                    if db.child("Back").get().val():
                        i=i-1
                        if(i<0):
                            i=len(a)-1
                        db.update({"/TramPhat1/Back":False})
                        j=0
                    while db.child("/TramPhat1/Pause").get().val():
                        pass                       
                    hinhnen.capnhathinhanh(a[i])    
                    time.sleep(1)
                i=i+1
                if(i==len(a)):
                    i=0
                
        pygame.quit()

if __name__ == "__main__":
    Main()

