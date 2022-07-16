import pyrebase
firebaseConfig = {
  'apiKey': "AIzaSyATfhIehc5XZThp6Z3Mc4xeeZzfgy33Iks",
  'authDomain': "doantn-e31d0.firebaseapp.com",
  'databaseURL': "https://doantn-e31d0-default-rtdb.firebaseio.com",
  'projectId': "doantn-e31d0",
  'storageBucket': "doantn-e31d0.appspot.com",
  'messagingSenderId': "7468310234",
  'appId': "1:7468310234:web:9711da5592d0bae0cc8fe3",
  'measurementId': "G-0NM7TR6YMX"
};
##################
firebase=pyrebase.initialize_app(firebaseConfig)
storage=firebase.storage()
#storage.child("main.py").put("main.py")
storage.child("/anh1.jpg").download("/","anh1.jpg")
storage.child("/anh2.jpg").download("/","anh2.jpg")
storage.child("/anh3.jpg").download("/","anh3.jpg")
storage.child("/anh4.jpg").download("/","anh4.jpg")
