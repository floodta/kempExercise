import MySQLdb

#######################
#   DATABASE CONFIG   #
#######################

def execute_db_command(sql, values):
    
    db = MySQLdb.connect("127.0.0.1","root","root","kempexercise" )
    cur = db.cursor()
   
    cur.execute(sql, values)
    db.commit()
    results = cur.fetchall()  
    cur.close()
    db.close()
    return results

def get_valid_userId(username, password):
	results = execute_db_command("SELECT id FROM user_table WHERE userName = %s and password = %s;", [username, password])      
	if len(results) == 1: 
		return results[0][0]
	else:
		return -1
		
def get_list_of_servers_allowed(id):
	return execute_db_command("SELECT * FROM user_server_table where userId = %s order by serverId;",  [id])
	
def get_list_of_servers(clusterId):
	return execute_db_command("select id from server_table where clusterId = %s;",  [clusterId])
	
def get_list_of_clusters(id):
	return execute_db_command("select DISTINCT clusterId from server_table join user_server_table on user_server_table.serverId ="
                                +" server_table.id where user_server_table.userId = %s;",  [id])
								
def get_access_attempts(serverId):
	return execute_db_command("SELECT userId, serverId, success, dateStamp FROM service_access_table where serverId = %s;",  [serverId])

def add_server(ipAddress, clusterId, nickName):
	results = execute_db_command("insert into server_table (ipAddress, clusterId, name) values (%s,%s,%s);",  [ipAddress, clusterId, nickName])
	return execute_db_command("select * from server_table where ipAddress = %s and  clusterId = %s and name = %s",[ipAddress, clusterId, nickName])