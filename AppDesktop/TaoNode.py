from kivy_garden.mapview import MapView
from kivy.clock import Clock
from kivy.app import App
from HienThi import Manphu
from kivy.core.window import Window
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
class taonode(MapView):
    Window.maximize()
    getting_markets_time=None
    TenCacNode=[]
    def start_getting_markets_in_fov(self):
        try:
            self.getting_markets_timer.cancel()
        except:
            pass
        self.getting_markets_timer = Clock.schedule_once(self.get_markets_in_fov, 1)

    def get_markets_in_fov(self, *args):
        #Kết nối cơ sở dữ liệu
        app=App.get_running_app()
        sql_statement = '''SELECT * FROM node'''
        app.cursor.execute(sql_statement)
        #Lấy dữ liệu từ cơ sở dữ liệu
        CoSoDuLieu=app.cursor.fetchall()
        #print(markets)
        for i in CoSoDuLieu:
            name=i[1]
            if name in self.TenCacNode:
                continue
            else:
                self.add_market(i)
    def add_market(self,ThongTinNode):

        #Tao nut nhan va khung bieu tuong
        lat,lon=ThongTinNode[3],ThongTinNode[4]
        text=''
        print(ThongTinNode[2])
        if(db.child("/"+ThongTinNode[2]+"/Status").get().val()=='Good'):
            text='Xanh.png'
        elif(db.child("/"+ThongTinNode[2]+"/Status").get().val()=='Bad'):
            text = 'Do.png'
        else:
            text = 'Den.png'
        HienThiManphu=Manphu(lat=lat,lon=lon,source=text)
        HienThiManphu.DulieuNode=ThongTinNode
        self.add_widget(HienThiManphu)
        name = ThongTinNode[1]
        self.TenCacNode.append(name)