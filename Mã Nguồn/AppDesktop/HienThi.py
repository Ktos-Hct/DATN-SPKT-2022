from telnetlib import IP
from kivy_garden.mapview import MapMarkerPopup
from kivy.uix.gridlayout import GridLayout
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.popup import Popup
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.image import Image
import cv2
from kivy.clock import Clock
#import requests
#import json
from kivy.graphics.texture import Texture
#
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
status=db.child("diekien").get()
#firebaseurl="https://doantn-e31d0-default-rtdb.firebaseio.com/.json"
#Ma = "Run"
Khoabandau = True
class Manphu(MapMarkerPopup):
    DulieuNode=[]
    def on_release(self):
        self.momanhinhphu()
    def momanhinhphu(self):
        self.image=Image(pos_hint={'center_x':0.4,'center_y':0.5},size_hint=(1, 1))
        self.capture=cv2.VideoCapture(db.child("/"+self.DulieuNode[2]+"/Link").get().val()+"/stream.mjpg")
        Clock.schedule_interval(self.load_video,1.8/38.8)
        ####
        layout=GridLayout(cols=2,spacing=[1,1])
        floatlayout1=FloatLayout(size_hint=(0.2,0.3))
        floatlayout2=FloatLayout(size_hint=(0.2,0.7))
        global Ma
        buttonBack=Button(text="Back",size_hint=(0.2,0.1),pos_hint={'center_x':0.1,'center_y':0.9},background_color=[0, 0, 1, 1],on_press=self.Back)
        buttonPause=Button(text="Pause",size_hint=(0.2,0.1),pos_hint={'center_x':0.3,'center_y':0.9},background_color=[0, 0, 1, 1],on_press=self.Pause)
        buttonNext=Button(text="Next",size_hint=(0.2,0.1),pos_hint={'center_x':0.5,'center_y':0.9},background_color=[0, 0, 1, 1],on_press=self.Next)
        button1 = Button(text="TatCT", size_hint=(0.2, 0.1), pos_hint={'center_x': 0.1, 'center_y': 0.8},background_color=[0, 0, 1, 1],on_press=self.tatqc)
        button1Thoat=Button(text="Reboot", size_hint=(0.2, 0.1), pos_hint={'center_x': 0.3, 'center_y': 0.8},background_color=[0, 0, 1, 1],on_press=self.reboot)
        button2 = Button(text="Exit", size_hint=(0.1, 0.1), pos_hint={'center_x': 0, 'center_y': 0.05},background_color=[1, 1, 1, 1],on_press=self.tat)
        IdNode=Label(text="ID: "+str(self.DulieuNode[0]),pos_hint={'center_x': 0.05,'center_y':0.7})
        Thongbao1 = Label(text="Hinh anh tu Camera " , pos_hint={'center_x': 0.4, 'center_y': 0.95})
        Trangthai=Label(text=" Status: "+db.child("/"+self.DulieuNode[2]+"/Status").get().val(),pos_hint={"right":0.6,"top":1.15},color=[0,0,1,1])
        Ip=Label(text="Ip: "+db.child("/"+self.DulieuNode[2]+"/Ip").get().val(),pos_hint={"right":0.65,"top":1.1},color=[0,0,1,1])
        date=Label(text=" Date: "+db.child("/"+self.DulieuNode[2]+"/Date").get().val(),pos_hint={"right":0.625,"top":1.05},color=[0,0,1,1])
        layout.add_widget(floatlayout1)
        layout.add_widget(floatlayout2)
        floatlayout1.add_widget(buttonBack)
        floatlayout1.add_widget(buttonPause)
        floatlayout1.add_widget(buttonNext)
        floatlayout1.add_widget(button1)
        floatlayout1.add_widget(button1Thoat)
        floatlayout1.add_widget(IdNode)
        floatlayout1.add_widget(Trangthai)
        floatlayout1.add_widget(Ip)
        floatlayout1.add_widget(date)
        floatlayout2.add_widget(Thongbao1)
        floatlayout2.add_widget(button2)
        floatlayout2.add_widget(self.image)
        self.popupWindow = Popup( title="Tram Phat Quang Cao "+str(self.DulieuNode[1]), content=layout, size_hint=(0.5, 0.5),auto_dismiss=False,title_align='center',title_color=[0, 1, 1, 1])
        self.popupWindow.open()  # show the popup
        #if()

    def load_video(self,*args):
        try:
            ret,frame=self.capture.read()
            self.image_frame=frame
            buffer=cv2.flip(frame,0).tostring()
            texture=Texture.create(size=(frame.shape[1],frame.shape[0]),colorfmt='bgr')
            texture.blit_buffer(buffer,colorfmt='bgr',bufferfmt='ubyte')
            self.image.texture=texture
        except:
            pass
    def tat(self,*args):
        self.capture.release()
        cv2.destroyAllWindows()
        self.popupWindow.dismiss()
    def TaiQuangCao(self,*args):
        db.update({"DowloadQC": "https://www.youtube.com/watch?v=wub1_ZWgmO0"})
    def tatqc(self,*args):
        "/"+self.DulieuNode[2]+"/Date"
        return db.update({"/"+self.DulieuNode[2]+"/Condition":not db.child("/"+self.DulieuNode[2]+"/Condition").get().val()})
    def Pause(self,*args):
        return db.update({"/"+self.DulieuNode[2]+"/Pause":not db.child("/"+self.DulieuNode[2]+"/Pause").get().val()})
    def Next(self,*args):
        return db.update({"/"+self.DulieuNode[2]+"/Next":True})
    def Back(self,*args):
        return db.update({"/"+self.DulieuNode[2]+"/Back":True})
    def reboot(self,*args):
        return db.update({"/"+self.DulieuNode[2]+"/Reboot":True})

