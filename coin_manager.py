# I assume use of pipenv install

# Import main Flask class and render_template for use with jinja files, as well as
# request for http and other http response functions
from flask import Flask, render_template, request, redirect, session, jsonify  

# Get utility classes
from flaskext.mysql import MySQL
from flask_bcrypt import Bcrypt
import requests
import json

# get config data
from Config import Config
config = Config()

# create a Flask app and store it in "app"
app = Flask(__name__)
# create an instance of the mysql class
mysql = MySQL()
# Add to the app (Flask object) some config data for our connection
app.config['MYSQL_DATABASE_USER'] = config.db_user
app.config['MYSQL_DATABASE_PASSWORD'] = config.db_password
# The name of teh database we want to connect to at the DB server
app.config['MYSQL_DATABASE_DB'] = config.database
# Where teh MYSQL server is at
app.config['MYSQL_DATABASE_HOST'] = config.db_host
# use the mysql object's method "init_app" and pass it the flask app object
mysql.init_app(app)
# create a bcrypt object from the bcrypt class, and pass it the flask app object
bcrypt = Bcrypt(app)

# Sessions require a secret_key for security. Random guid (I just slammed on the keyboard like an angry cat)
app.secret_key = '@$%HYwtreu;u5wgmejlNBO&*HJIWOY,VAXSTOVLY4GERQ'

# A route to inject vars into all templates.
# This is for use in the navbar. Every route needs to know about the user var
# Rather than put "user" with logic into every route, put it in context_processor
# which runs before template rende
@app.context_processor
def inject_user():
	if 'full_name' in session:
		return dict(user=session['full_name'])
	else: 
		return dict(user="noAuth")

@app.route("/", methods=["GET"])
def index():
	# Make sure username is in session dict... if so proceed.
	if 'full_name' in session:
		print session['uid']
		#Create a connection
		conn = mysql.connect()
		# set up a cursor object so the sql object can run queries
		cursor = conn.cursor()

		# ===============Get this users coins===============
		# ===============user_coins===============
		user_coins_query = ('SELECT cid, ammount,c.* FROM user_coins uc'
					 'INNER JOIN coins c on c.id = cid '
					 'WHERE uid = %s ')
		# Run the query
		cursor.execute(user_coins_query, int(session['uid']))
		# Turn the query into something Python can use via fetchall
		user_coins = cursor.fetchall()
		# ==================================================

		# ===============Get the price of top coins + user coin===============
		# ===============main_coin_prices===============
		main_coin_query = ('SELECT symbol FROM '
			'(SELECT symbol FROM coins WHERE cc_sort_order <= 10 ORDER BY coins.cc_sort_order asc) '
				'as sorted_coins '
			'UNION '
			' SELECT coin FROM users WHERE id = %s ')
		cursor.execute(main_coin_query, int(session['uid']))
		# Turn the query into something Python can use via fetchall and store in coin_list
		coin_list = cursor.fetchall()
		# SQL gives us a tuple of lists. We need a simple 1-dimensional list. 
		# Convert (need 2nd elem, hence [0])
		coin_list_as_array = [(i[0]) for i in coin_list]
		# convert array to string
		coin_list_as_string = ','.join(coin_list_as_array)
		# get data from api
		user_and_main_coin_prices = requests.get("https://min-api.cryptocompare.com/data/price?fsym=USD&tsyms="+coin_list_as_string).json()
		# ====================================================================

		# To render the template...
		# we need a version for JS AND jinja for both vars.
		# We convert to json with json.dumps and burn the 'u' from the dict for JS
		# Jinja expects a python dict, so nothing to do 
		return render_template('home.html',
			coin_prices=(json.dumps(user_and_main_coin_prices)
				.replace(u'<', u'\\u003c')
    			.replace(u'>', u'\\u003e')
    			.replace(u'&', u'\\u0026')
    			.replace(u"'", u'\\u0027')),
			coin_prices_jinja=user_and_main_coin_prices,
			user_coins=(json.dumps(user_coins)
				.replace(u'<', u'\\u003c')
    			.replace(u'>', u'\\u003e')
    			.replace(u'&', u'\\u0026')
    			.replace(u"'", u'\\u0027')),
			user_coins_jinja=user_coins
		)
	# You have no ticket. No soup for you!
	else:
		return redirect('/login?msg=mustLogin')

# Not much to explain here. On Get /register, load template
@app.route("/register", methods=["GET"])
def register():
	return render_template(
		'register.html')

@app.route("/register-submit", methods=["POST"])
def register_submit():
	# get vars from form
	password = request.form['password']
	full_name = request.form['full_name']
	email = request.form['email']
	coin = request.form['coin']

	# Make sure the user has given us a pass and full_name or send them back to /register
	if not password or not full_name or not email or not coin:
		return redirect('/register?msg=incomplete')

	# We have a pass and user... proceed to insert new user
	#### Add check user exists later####
	# hash the password from english by sending it through bcrypt (for defense against rainbow tables!)
	hashed_password = bcrypt.generate_password_hash(password)

	#Create a connection
	conn = mysql.connect()
	# set up a cursor object so the sql object can run queries
	cursor = conn.cursor()

	query = "INSERT INTO users VALUES (DEFAULT, %s, %s, %s, %s)"
	# execute a query with the execute method, and send through the placeholder vars
	result = cursor.execute(query, (full_name, hashed_password, coin, email))
	# if success, commit the change so the db completes insert
	if result == 1:
		conn.commit()
		conn.close()
		# All done... you may proceed, user, but before you do... let me give you a ticket!
		session['full_name'] = request.form['full_name']
		# this user's id will be the last inserted id into the db. Get it and set it
		session['uid'] = cursor.lastrowid
		# send to homepage
		return redirect('/')
	else:
		# SQL query failed. Probably our fault, but send user to /register
		return redirect('/register?msg=reg_failed')



@app.route("/login", methods=["GET"])
def login():
	return render_template(
		'login.html')

# Post from login form
@app.route("/login-submit", methods=["POST"])
def login_submit():
	# get vars from form
	password = request.form['password']
	email = request.form['email']

	# Ensure vars came through or send user back to login
	if not password or not email:
		return redirect('/login?msg=incomplete')

	conn = mysql.connect()
	cursor = conn.cursor()
	user_query = "SELECT * FROM users WHERE email = %s"
	cursor.execute(user_query, email)
	data = cursor.fetchall()
	hashed_password = data[0][2]
	# check the hash against the english password they gave us by running through bcrypt
	pass_match = bcrypt.check_password_hash(hashed_password, password)
	# pass_match will be true if match, false if not
	if not pass_match:
		# No soup for you. Goodbye. (bad user/pass combo)
		return redirect('/login?msg=badPass')
	else:
		# Set up session vars, and move them to /
		session['full_name'] = data[0][1]
		session['email'] = data[0][4]
		session['coin'] = data[0][3]
		session['uid'] = data[0][0]
		return redirect('/')

# Similar to login-submit. Process add-coin form on home page
@app.route("/add-coin", methods=["POST"])
def add_coin():
	# get vars from form
	user_symbol = request.form['symbol']
	user_amount = request.form['amount']

	if not user_symbol or not user_amount:
		return redirect('/?msg=badCoin')

	#Create a connection
	conn = mysql.connect()
	# set up a cursor object so the sql object can run queries
	cursor = conn.cursor()

	# get coin id and if user has any
	user_query = "SELECT coins.*,user_coins.ammount FROM coins LEFT JOIN user_coins on user_coins.cid = coins.id WHERE symbol = %s"
	# # Run the query
	cursor.execute(user_query, user_symbol)
	# # Turn the query into something Python can use via fetchall
	data = cursor.fetchall()
	coin_id = data[0][0]
	if data[0][9] == None:
		query = "INSERT INTO user_coins VALUES (DEFAULT, %s, %s, %s)"
		result = cursor.execute(query, (session['uid'], coin_id, user_amount))
	else: 
		query = "UPDATE user_coins SET ammount = %s+ammount WHERE uid = %s AND cid = %s"
		result = cursor.execute(query, (user_amount,session['uid'], coin_id))
	if result > 0:
		conn.commit()
		conn.close()
		return redirect('/')
	else:
		return redirect('/?msg=db_error')

@app.route('/logout')
def logout():
	# Nuke their session vars. This will end the session which is waht we use to let them into the portal
	session.clear()	
	return redirect('/login')

if __name__ == "__main__":
	app.run(host=config.app_host,port=config.app_port,debug=config.debug_on)
