from flask import Flask, session, redirect, url_for, escape, request, render_template
import kempApi

app = Flask(__name__)



@app.route('/')
def index():
    if 'username' in session:
        username_session = escape(session['username']).capitalize()
        return redirect(url_for('menu'))
    return redirect(url_for('login'))

@app.route('/menu')
def menu():
    return render_template('menu.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if 'username' in session:
        return redirect(url_for('index'))
    if request.method == 'POST':
        username_form  = request.form['username']
        password_form  = request.form['password']

        userId = kempApi.get_valid_userId(username_form, password_form) 
        if userId != -1:
            session['username'] = request.form['username']
            session['userId'] = userId
        
            return redirect(url_for('menu'))
            
        else:
            error = "Invalid Credential"
    return render_template('login.html', error=error)

@app.route('/serversList')
#Retrieve the list of servers to which the user that is invoking the API has access
def serversList():
    id = session['userId']
    results = execute_db_command("SELECT * FROM user_server_table where userId = %s order by serverId;",  [id])
    return render_template('serversList.html', results=results)


@app.route('/clustersList')
#Retrieve the list of clusters that contain at least 1 server to which the user that invoking the API has access
def clustersList():
    id = session['userId']
    results = execute_db_command("select DISTINCT clusterId from server_table join user_server_table on user_server_table.serverId ="
                                +" server_table.id where user_server_table.userId = %s;",  [id])
    return render_template('clustersList.html', results=results)

@app.route('/inputClusterId')
def inputClusterId():
    return render_template('inputClusterId.html')

@app.route('/inputServerId')
def inputServerId():
    return render_template('inputServerId.html')

@app.route('/addServerRow')
def addServerRow():
    return render_template('addServerRow.html')

@app.route('/listOfServers', methods=['GET', 'POST'])
#Retrieve the list of servers that belong to a specified cluster
def listOfServers():
    if request.method == 'POST':
        clusterId  = request.form['clusterId']
        print(clusterId)
        results = execute_db_command("select id from server_table where clusterId = %s;",  [clusterId])
        return render_template('clusterId.html', results=results)
   

@app.route('/accessAttempts', methods=['GET', 'POST'])
#Retrieve the list of access attempts for each user against a particular server 
def accessAttempts():
    print("tzf1 ")
    if request.method == 'POST':
        serverId  = request.form['serverId']
        
        print(serverId)
        results = execute_db_command("SELECT userId, serverId, success, dateStamp FROM service_access_table where serverId = %s;",  [serverId])
        return render_template('userServerAttempts.html', results=results)


@app.route('/addServer', methods=['GET', 'POST'])
#Add a server to a cluster by specifying an IP, nickname, cluster to which belongs
def addServer():
    if request.method == 'POST':
        ipAddress  = request.form['IPAddress']
        nickName  = request.form['nickName']
        clusterId  = request.form['clusterId']
       
        results = execute_db_command("insert into server_table (ipAddress, clusterId, name) values (%s,%s,%s);",  [ipAddress, clusterId, nickName])
        results = execute_db_command("select * from server_table where ipAddress = %s and  clusterId = %s and name = %s",[ipAddress, clusterId, nickName])
        
        return render_template('serverAdded.html', results=results)
    


@app.route('/returnToMenu')
def returnToMenu():
    return redirect(url_for('menu'))


@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('index'))

app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

if __name__ == '__main__':
    app.run(debug=True)
