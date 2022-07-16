from kivy.app import App
from TaoNode import taonode
import sqlite3
import pyrebase
class MainApp(App):
    connection = None
    cursor = None
    def on_start(self):
    #    marker= MapMarkerPopup(lat=10.762622,lon=106.660172,source= "img.png")
    #    marker.add_widget(Button(text="Hien thi truc tiegâp"))
    #    self.root.add_widget(marker)
        #ket noi co so du lieu
        self.connection = sqlite3.connect("Dulieu.db")
        self.cursor=self.connection.cursor()


    pass
MainApp().run()