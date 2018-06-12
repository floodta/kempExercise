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

@app.route('/servers_list')
#Retrieve the list of servers to which the user that is invoking the API has access
def servers_list():
    id = session['userId']
    results = kempApi.get_list_of_servers_allowed(id)
    return render_template('serversList.html', results=results)


@app.route('/clusters_list')
#Retrieve the list of clusters that contain at least 1 server to which the user that invoking the API has access
def clusters_list():
    id = session['userId']
    results = kempApi.get_list_of_clusters(id)
    return render_template('clustersList.html', results=results)

@app.route('/input_cluster_id')
def input_cluster_id():
    return render_template('inputClusterId.html')

@app.route('/input_server_id')
def input_server_id():
    return render_template('inputServerId.html')

@app.route('/add_server_row')
def add_server_row():
    return render_template('addServerRow.html')

@app.route('/list_of_servers', methods=['GET', 'POST'])
#Retrieve the list of servers that belong to a specified cluster
def list_of_servers():
    if request.method == 'POST':
        clusterId  = request.form['clusterId']
        results = kempApi.get_list_of_servers(clusterId)
        return render_template('clusterId.html', results=results)   

@app.route('/access_attempts', methods=['GET', 'POST'])
#Retrieve the list of access attempts for each user against a particular server 
def access_attempts():
    if request.method == 'POST':
        serverId  = request.form['serverId']
        results = kempApi.get_access_attempts(serverId)
        return render_template('userServerAttempts.html', results=results)


@app.route('/add_server', methods=['GET', 'POST'])
#Add a server to a cluster by specifying an IP, nickname, cluster to which belongs
def add_server():
    if request.method == 'POST':
        ipAddress  = request.form['IPAddress']
        nickName  = request.form['nickName']
        clusterId  = request.form['clusterId']
        results = kempApi.add_server(ipAddress, clusterId, nickName)
        return render_template('serverAdded.html', results=results)
    


@app.route('/return_to_menu')
def return_to_menu():
    return redirect(url_for('menu'))


@app.route('/logout')
def logout():
    session.pop('username', None)
    return redirect(url_for('index'))

app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

if __name__ == '__main__':
    app.run(debug=True)
