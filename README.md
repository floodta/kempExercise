

Setup
1. Create Database: from mysql run KempDBInit.sql. 
This will create the database kempexercise.
2. run 
    pip install Flask
    pip install MySQLdb
2. run python app.py
3. Enter details for user and password : e.g. username = kemp, password = limerick

 
Description of Database
Based on the following definitions:

    User = Entity uniquely identified by a username and password
    Server = Entity to which one or more users can have access
    Cluster = Collection of servers
    A user can have access to multiple servers
    A server can belong to only 1 cluster
    A cluster can contain multiple servers
    
    The following tables were created:
        server_table
        user_table_table
        user_table
        cluster_table
        server_access_table
 
Description of modules
def index

  purpose: redirect to login if user is not in session.  

def menu

  purpose: calls menu which list requirement to be met by API.

def login

  purpose: validate usernanme and password and get user id for session. 
  methods: GET POST
  params: username password
  return: user id for session, direct to menu, else error. 

def servers_list

  purpose: Retrieve the list of servers to which the user that is invoking the API has access
  params:userId
  return: returns list of servers allowed in serversList.html

def clusters_list

  purpose: Retrieve the list of clusters that contain at least 1 server to which the user that invoking the API has access
  param: userId
  return: list of clusters in clustersList.html

def input_cluster_id

  purpose: allows user to input cluster id 

def input_server_id

  purpose: allows user to input server id 

def add_server_row

  purpose: allows user to input server row

def list_of_servers

  purpose: Retrieve the list of servers that belong to a specified cluster
  methods: GET POST
  param: clusterId
  return list of servers in clusterId.html

def access_attempts

  purpose: Retrieve the list of access attempts for each user against a particular server 
  method: GET POST
  param: serverId
  return: list of access attempts in userServerAttempts.html

def add_server

  purpose: Add a server to a cluster by specifying an IP, nickname, cluster to which belongs
  method: GET POST
  params: ipAddress, clusterId, nickName
  return details of server added in serverAdded.html

def return_to_menu

  purpose: allow user to return to menu

def logout:  

  purpose: allow user to logout of session

module kempapi
def execute_db_command
purpose: connect adef get_valid_userId(username, password):nd access database

def get_valid_userId

  params: username, password
  
  def get_list_of_servers_allowed
  
   params: id
  
  def get_list_of_servers
    param: clusterId
 
 def get_list_of_clusters
  param: id
  
  def get_access_attempts
    param: serverId
    
  def add_server
    param: ipAddress, clusterId, nickName
    param id


