import os
import pyrebase
import datetime
import multiprocessing
import os
import subprocess
import requests
config = {
    "apiKey": "AIzaSyATfhIehc5XZThp6Z3Mc4xeeZzfgy33Iks",
    "authDomain": "doantn-e31d0-default-rtdb.firebaseio.com",
    "databaseURL": "https://doantn-e31d0-default-rtdb.firebaseio.com",
    "storageBucket": "doantn-e31d0",
}
##################
firebase=pyrebase.initialize_app(config)
db=firebase.database()
# importing multiprocessing và os module
res = str(subprocess.check_output(['hostname', '-I'])).split(' ')[0].replace("b'", "")

def worker2():
    cmd = 'python3 mjpg.py'
    os.system(cmd)
def worker1():
    #cmd3 = './ngrok http 8000'
    #os.system(cmd3)
    r = requests.get('http://localhost:4040/api/tunnels')
    datajson = r.json()
    msg = ""
    for i in datajson['tunnels']:
        msg = msg + i['public_url']
    db.update({"/TramPhat1/Link": msg})
    db.update({"/TramPhat1/Ip": res})
    db.update({"/TramPhat1/Status":"Good"})
    db.update({"TramPhat1/Date":str(datetime.date.today())})
    return 0
    
if __name__ == "__main__":

    p1 = multiprocessing.Process(target=worker1)
    p2 = multiprocessing.Process(target=worker2)
    p1.start()
    p2.start()
    cmd3 = 'python3 download.py'
    os.system(cmd3)
    cmd2 = 'python3 quangcao.py'
    os.system(cmd2)
    p1.join()
    p2.join()
    print("Done")