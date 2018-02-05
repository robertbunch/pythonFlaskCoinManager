# A tiling weather widget, built in Rails 5 and PostGres with Puma, and a little isotope coffee script on the front.
## Purpose: A Rails app that uses connecting to PostGres for AWS deployment course students.

### Overview
I had not used Rails professionally since beta 4, so I had to relearn Rails. Please don't hate if I did something stupid. I will gladly update code if there are suggestions. I generated a scaffold for the tile (called city_weathers). Check the gem file for any unknown gems, but the only ones I added to the rails 5 generator were [masonry-rails](https://github.com/kristianmandrup/masonry-rails) and [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails). The site (obviously) uses bootstrap, and I used masonry to include isotope to give it a little front-end pizzaz with coffeescript. 

There is no database seed. Rake and you'll be set.

A DB_Cred.py file is neccessary. This file just contains the api key. I used environmental variables so that will relate primarily to our AWS server.It follows the following format, but you will need to update credentials if they are different:
```
class DB_Cred():
  def __init__(self):
    self.host = '127.0.0.1'
    self.database = 'coin_manager'
    self.user = 'x'
    self.password = 'x'

```

# Make sure to connect your domain to your machines IP address

# Steps to deploy:
1. Install apache2
2. Open up port 80/443 in the firewall [AWS Console](https://aws.amazon.com/)
3. Test out Apache at port 80
4. Install pip
5. Install [pipenv](https://github.com/pypa/pipenv) to stand in as both pip and virtualenv
6. Install mysql/pg


Set password for mysql
open port 80, 443, 5000
pipenv shell
- creates virtualenv
- $deactivate 
-- (to leave)
- $ pipenv --venv
-- will locate this venv
- $ source PATH_TO_VENV/bin/activate
-- fire it back up
change app.run(debug=True) to
  app.run(host='0.0.0.0',port=5000)
Check site, Test
Set up pancakes
import db
create vhost
========
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
=========
[Flask and wsgi docs](http://flask.pocoo.org/docs/0.12/deploying/mod_wsgi/)
create wsgi file
#!/usr/bin/python
activate_this = '/home/ubuntu/.local/share/virtualenvs/cm-Mg75QJy5/bin/activate_this.py'
execfile(activate_this, dict(__file__=activate_this))

import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/cm/")

from flaskMysql import app as application
application.secret_key = '34qtGQ#T$tWEet#$reasgEWRdsfGSge'

sudo tail -f /var/log/apache2/error.log 

$ sudo apt-get install libapache2-mod-wsgi
$ sudo a2enmod wsgi



==================


2. Clone the repository to /var/www (nginx created this dir)

5. Test/Run the server and see if it works!
6. Use config/log to solve errors
7. Add missing gitignore files (weather.yml)
8. Install Puma.
9. Get Puma running in the background
10. After installing or making changes to puma.service double check status
11. Check for Puma (system) errors
12. Check for rails errors
13. Make nginx vhost (or copy an Apache one if using the same server as Node)
14. Link up the vhost, test and restart nginx
15. Set up RAILS_ENV in the rbenv file or change the ruby 


=============
# Steps in detail
1. Install nginx
```
$ sudo apt install nginx
```
I do not like to use rvm with a production server. It is much easier to use rbenv. rvm is great for development, but use it at your own risk here.

```
$ sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

Add rbenv to path so we can access it anywhere
```
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
```
Reload bash to include the new path
```
$ source ~/.bashrc
```
Make sure it is working from any location"
```
$ type rbenv
```
Install preferred version of Ruby (I am using 2.3.1)
```
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
$ rbenv install 2.3.1
$ rbenv global 2.3.1
$ ruby -v
```

Get rbenv-vars plugin (so it's easy to use environment variables)
```
$ cd ~/.rbenv/plugins
$ git clone https://github.com/sstephenson/rbenv-vars.git
```

Install rails (will get default)
```
$ gem install rails
```
Alternately, to get specific use 
```
$ gem install rails -v 4.2.7 
```

2. Clone the repository to /var/www (nginx created this dir)
```
$ sudo chown -R ubuntu www
$ git clone YOUR_GIT_REPO
```

3. Start doing the Rails stuff
```
$ bundle install 
COMMENT: FAIL - this kicked my butt. The pg gem requires an Ubuntu package or it will not install!
$ sudo apt-get install libpq-dev
$ bundle install
COMMENT: It tells us we need JS runtime. Let's ignore it and see if we can get by
$ rake secret
#COMMENT: FAIL - missing node!! Go fetch it
$ curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
$ sudo apt-get install -y nodejs
#COMMENT: - now we can rake secret!
$ rake secret
```
Rake secret will generate a very, very long hash. Copy it
Now we create a .rbenv-vars file for the plugin to read. Make sure you are inside your project's directory:
```
$ vi .rbenv-vars
```
Hit the "i" key to go into insert mode.
Set up the vars the application needs. In my case:
```
$ SECRET_KEY_BASE=
$ WT_DATABASE_USER=
$ WT_DATABASE_PASSWORD=
$ WEATHER_API_KEY
```

If you run this, you should see your variables:
```
$rbenv vars
```

4. Set up Postgres. I strongly advise you make the user and db name both LOWERCASE!!
```
$ sudo apt install postgresql
$ sudo -u postgres createdb DB_NAME_HERE
$ sudo -u postgres createuser -s USER_NAME_HERE
```
You have now installed Postgres, created the db, and created a user. Now, log into Postgres and update the users password:
```
$ sudo -u postgres psql
Query option 1. ALTER USER weatherTiler WITH PASSWORD '123456';
Query option 2. \password weathertiler
#COMMENT - this will show you all your users and their privilages
\du 
\q to quit
```

If you did everything in order, this is not neccessary, but if you have permission issues, you can run
```
GRANT ALL PRIVILEGES ON DATABASE YOUR_DB to YOUR_USER;

```

Check over your config/database.yml to make sure everything matches what you just did in Postgres.

4. Rake the DB! Using rails, this will create the tables, set up any data, and precompile all pipeline assets (css, js)
```
$ RAILS_ENV=production rake db:create
$ RAILS_ENV=production rake db:migrate
$ RAILS_ENV=production rake assets:precompile
```


5. Test/Run the server and see if it works!
- Make sure port 3000 (or whatver port you are listening on) is open in the AWS firewall
- make sure you have allowed static assets in your production.rb env file or it won't serve css and js
-- In the main production.rb file, you'd comment out this this: line "config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?"
```
RAILS_ENV=production rails server --binding=YOUR_AWS_IP_ADDRESS
````

6. Use config/log to solve errors
7. Add missing gitignore files (weather.yml)

8. Now, finally Puma.
```
$ gem install puma 
#COMMENT: - it may be install locally from your dev/repo, but it needs to be installed globally for nginx to use it
#COMMENT: - loc --> /home/ubuntu/.rbenv/shims/puma
#COMMENT: - You are using a t2 micro so you have one core.
#COMMENT: - You can double check with this: 
$ grep -c processor /proc/cpuinfo
```

Make sure you have a puma.rb file in the config folder. It should look like this:
```
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count
port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "production" }
# Only have 1 core, so ignore workers directive
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }
# preload_app!
# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
```


9. Get Puma running in the background
UBUNTU 16.04 does not use upstart which you may find elsewhere on the web. Instead, we need to make a service and daemonize Puma so it can run in the background.
Docs here explain how to set it up as a service:
[https://github.com/puma/puma/blob/master/docs/systemd.md](https://github.com/puma/puma/blob/master/docs/systemd.md)
- change the WD to app location
- update user

```
$ sudo vi /etc/systemd/system/puma.service
```

My puma.service looks like the below.
Note that the User is ubuntu becuase that is the user we use in AWS. You can of course create a dedicated user for your Rails app.
WorkingDirectory is where your app is at.
The puma command for ExecStart and ExecStop needs to know where teh puma.rb file is at in your app.
```
[Unit]
Description=Puma Rails Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/var/www/wt
ExecStart=/home/ubuntu/.rbenv/bin/rbenv exec bundle exec puma -C /var/www/wt/config/puma.rb
ExecStop=/home/ubuntu/.rbenv/bin/rbenv exec bundle exec pumactl -S /var/www/wt/tmp/pids/puma.state stop
TimeoutSec=15
Restart=always


[Install]
WantedBy=multi-user.target
```

10. After installing or making changes to puma.service, we need to:
- reload all daemons
- enable so it starts on boot
- start it now
- check the status
```
$ sudo systemctl daemon-reload
$ sudo systemctl enable puma.service
$ sudo systemctl start puma.service
$ sudo systemctl status puma.service
```

11. Check Puma (system) errors
```
sudo tail -f /var/log/syslog
```
12. Check rails errors
```
tail -f /var/www/wt/log/production.log
```

13. Make nginx vhost (or copy an Apache one if using the same server as Node)
```
$ sudo vi /etc/nginx/sites-available/YOUR_SITE.conf
```

Your NGINX vhost should look like this:
```
server {
    listen 80;
    server_name  wt.ridiculous-inc.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

14. Link up the vhost, test and restart nginx
```
$ sudo ln -s /etc/nginx/sites-available/apache /etc/nginx/sites-enabled/apache
$ sudo service nginx configtest
$ sudo service nginx reload
```

Test out the site. Probably fail.
Puma still thinks we are in development. 
15. Set up RAILS_ENV, or change it to production in config/puma.rb

## Check out Capistrano for extra credit


### Technologies Used
* Ruby
* Rails
* Postgres
* Puma
* rbenv
* coffeescript
* Bootstrap
* isotope.js


### Notes
The code is lightly commented, generally assuming you know the Rails MVC.

