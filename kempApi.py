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