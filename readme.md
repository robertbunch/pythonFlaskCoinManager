# A crypto currency coin manager, built in Python, Flask and MySQL with Apache and the WSGI module, and a little D3.js to make a groovy pie chart. I manage the environment with pipenv and the user auth system uses bcrypt for hashing passwords.

## Purpose: A Flask app that connects to MySQL and uses WSGI for AWS deployment course students. [Find the course here](https://www.udemy.com/deploying-web-apps-simplified-quick-or-in-depth-on-aws)

### Overview
The app is primarily in coin_manager.py and is heavily commented. Similar to Express, it uses routes with get/post methods, and makes use of various response mechanisms (json, render, etc.). Instead of virtualenv, which is the traditional canonical environment manager, I am using the new, and very awesome pipenv. It acts as both pip and virtualenv in one and can manage dependencies (think package.json). You can check out the Pipfile for detail, but I used flask, bcrypt, mysql, and requests. The site (obviously) uses bootstrap, and I used [d3](https://d3js.org/) to make the pie chart svg. jQuery fills in all the other gaps to save time on development, though React or Angular would fit nicely. 

There is a seed database called "coin_manager_seed_db.sql" in the repo. It contains no data; just structure.

A Config.py file is neccessary. This file contains db creds (db, username, pass, and host) as well as what to run in app.run(). There are a variety of ways to manage configuration data in Python, but I come from an OOP background so my tendency in Python is to throw everything into a class. You should change it on your local so the debugger is on (at least I like it).It uses the following format (Note, you will need to update the credentials, assuming they are different):
```
class Config():
  def __init__(self):
    self.db_host = '127.0.0.1'
    self.database = 'coin_manager'
    self.db_user = 'x'
    self.db_password = 'x'
    self.app_port = 5000
    self.debug_on = False
    self.app_host='0.0.0.0'

```


# Steps to deploy:
## I know it looks intimidating, but it's fairly quick. I am starting the server from scratch and went more granular on the steps
1. Connect the domain to the AWS machine's IP
2. Install apache2
3. Open up port 80/443 and port 5000 (for testing later, then close it) in the firewall [AWS Console](https://aws.amazon.com/)
4. Test out Apache at port 80
5. Install python
6. Install pip
7. Install [pipenv](https://github.com/pypa/pipenv) to stand in as both pip and virtualenv
8. Install MySQL (you can do pg, or whatever you use, but I use MySQL)
9. Set the root password for mysql
10. Set ownership of /var/www to ubuntu
11. git clone the repo into /var/www
12. run pipenv shell
13. use pipenv to install all packages
14. run your python file
15. Check port 5000 and follow logs for any errors
16. Connect Pancakes to the server
17. Create user, set password, give access, and import DB structure
18. Ensure config data for app.run() is set for prod
19. Create vhost
20. Create a wsgi file in app dir to satisfy vhost. [Flask and wsgi docs](http://flask.pocoo.org/docs/0.12/deploying/mod_wsgi/)
21. Install wsgi module and enable
22. Enable vhost
23. Restart apache
24. Check for erros in log (primarily, ensure that the permissions on your activate_this.py file are x for all)


# Steps in detail
1. Connect the domain to the AWS machine's IP

Wherever you registered your domain, set up an "a record" to point at your AWS IP

2. Install apache2
```
$ sudo apt install apache2
```
3.Open up port 80/443 and port 5000 (for testing later, then close it) in the firewall [AWS Console](https://aws.amazon.com/)

In the AWS console, go to your EC2 instance, scroll all the way to the right, and click on your security group. Click on the "inbound" tab at the bottom and add all 3 rules: http, https, and custom (5000, from everywhere)

4. Test out Apache at port 80
Once done with step 3, go your website and you should see the Apache Ubuntu welcome page.

5. Install python
On your AWS terminal run:
```
$ sudo apt install python-minimal
```

6. Install pip
```
$ sudo apt install python-pip
```


You can ensure both python and pip are installed like so:
```
$ which python
$ which pip
```

7. Install [pipenv](https://github.com/pypa/pipenv) to stand in as both pip and virtualenv
At this point, you may want to stick wtih what you know, but give this a chance. I have used virtualenv for a long time, and it's fantastic... but, the NEW AWESOME is here. pipenv can create a virtualenv AND can also act as a package manager/installer. Check out the documentation, but we can use it to "pip install", and on top of that, it will keep a Pipfile with all your packages, pretty much the same as the package.json file for node module management. 

```
$ pip install pipenv
```
We will run the commands later, but again, check out the [readme](https://github.com/pypa/pipenv) if you are interested in the basics.

8. Install MySQL (you can do pg, or whatever you use, but I use MySQL)
```
sudo apt install mysql-server
```
9. Set the root password for mysql
This is part of the last step (a loud purple screen) but it is critical you remember this.

10. Set ownership of /var/www to ubuntu

```
$ cd /var
$ sudo chown -R ubuntu /var/www
```

11. git clone the repo into /var/www
```
$ cd /var/www
$ git clone YOUR_GIT_REPO DIR_NAME_YOU_WANT
```

12. run pipenv shell
```
$ pipenv shell
```
This will create a virtualenv for you. You can keep your projects separate this way, use different versions of python, etc. Note where it says it installed the virtualenv. It should be something like:
/home/ubuntu/.local/share/virtualenvs/www-SOME_HASH/
Just type exit or deactivate if you want to leave the virtualenv
The command to actually fire it up is 
```
$ source /home/ubuntu/.local/share/virtualenvs/www-SOME_HASH/bin/activate
```

13. $ pipenv install (like package json, will fetch all pip packages)
```
$ pipenv install
```

Everything in your Pipfile will be loaded up in this virtualenv with only one command!

14. $ pipenv run python FILENAME.py 
```
$ pipenv run python FILENAME.py 
```
This will run your python file inside the virtualenv.
If you have any config files missing, upload them with filezilla or do it with vi
```
$ vi Config.py
hit "i" to go into insert mode
paste the Config.py contents
hit "escape" to leave insert mode
hold shift and hit z twice
```

15. Check port 5000 and follow logs for any errors
Go to your website and put :5000 at the end and see if your site loads!

16. Connect Pancakes to the server
17. Create user, set password, give access, and import DB structure
18. Ensure config data for app.run() is set for prod
19. Create vhost
```
<VirtualHost *:80>
        ServerName cm.ridiculous-inc.com
        WSGIScriptAlias / /var/www/cm/flaskapp.wsgi
        <Directory /var/www/cm>
            Order allow,deny
            Allow from all
        </Directory>
        Alias /static /var/www/cm/static
        <Directory /var/www/cm/static/>
            Order allow,deny
            Allow from all
        </Directory>
        ErrorLog ${APACHE_LOG_DIR}/error.log
        LogLevel warn
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

20. Create a wsgi file in app dir to satisfy vhost. [Flask and wsgi docs](http://flask.pocoo.org/docs/0.12/deploying/mod_wsgi/)
WSGI is awesome. It stands for Web Server Gateway Interface and if you want to know the whole story, check out [the pep](https://www.python.org/dev/peps/pep-3333/). If you want the short version, it allows Apache to read Python. Unlike Rails which needs Puma to run in the background, and Node which needs PM2, We dont have to start the Python server, Apache can just read it!
```
$ cd /var/www/cm
$ vi flaskapp.wsgi
```
hit "i" to go into insert mode.
paste this, but change the "coin_manager" to whatever your main python file is, and change the secret key to any hash:
```
#!/usr/bin/python
activate_this = '/home/ubuntu/.local/share/virtualenvs/cm-Mg75QJy5/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/cm/")

from coin_manager import app as application
application.secret_key = '34qtGQ#T$tWEet#$reasgEWRdsfGSge'
```


21. Install wsgi module and enable
```
$ sudo apt-get install libapache2-mod-wsgi
$ sudo a2enmod wsgi
```
This will fetch the apache module for wsgi.

22. Enable vhost
```
$ sudo a2ensite YOUR_VHOST.com.conf
```
If you get any errors, check the syntax'
```
$ sudo apachectl -t
```

23. Restart apache
```
$ sudo service apache2 restart
```

24. Check for erros in log (primarily, ensure that the permissions on your activate_this.py file are x for all)
```
$ sudo tail -f /var/log/apache2/error.log 
```
Once you've done that, open up the site at the domain and the log will update if there are errors.


### Technologies Used
* Python
* Flask
* pipenv
* MySQL
* Apache2
* WSGI
* D3
* jQuery
* Bootstrap
* isotope.js


### Notes
The main route file is heavily commented.

