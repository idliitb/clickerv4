package clicker.v4.databaseconn;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.concurrent.atomic.AtomicInteger;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
/**
 * 
 * @author rajavel, Kriti Clicker Team, IDL Lab - IIT Bombay
 * This class gives database connection from connection pool
 */
public class DatabaseConnection {
	public static AtomicInteger localconnectioncount = new AtomicInteger(0);
	public static AtomicInteger remoteconnectioncount = new AtomicInteger(0);
	
	public Connection createDatabaseConnection(){
		DataSource dataSource;
		Connection connection = null;
		// Get DataSource
		Context initContext = null;
		Context envContext = null;
		try {
			initContext = new InitialContext();
			envContext = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/aakashdb");
			connection = dataSource.getConnection();
			incrementCount();
		} catch (NamingException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}		
		
		return connection; 
	}
	
	public static void incrementCount(){
		localconnectioncount.incrementAndGet();			
		System.out.println("No of Open Connection in clickerv4 at aakashclicker DB : "+localconnectioncount);
	}
	
	public static void decrementCount(){
		localconnectioncount.decrementAndGet();			
		System.out.println("No of Open Connection after close in clickerv4 at aakashclicker DB : "+localconnectioncount);
	}
	
	public void closeLocalConnection(Connection con){
			
			try {
				con.close();
				decrementCount();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
	
	public Connection createRemoteDatabaseConnection(){
		DataSource dataSource;
		Connection connection = null;
		// Get DataSource
		Context initContext = null;
		Context envContext = null;
		try {
			initContext = new InitialContext();
			envContext = (Context)initContext.lookup("java:/comp/env");
			dataSource = (DataSource)envContext.lookup("jdbc/remotedb");
			connection = dataSource.getConnection();
			incrementRemoteCount();
		} catch (NamingException e) {
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}		
		
		return connection; 
	}
	
	public static void incrementRemoteCount(){
		remoteconnectioncount.incrementAndGet();			
		System.out.println("No of Open Connection in clickerv4 at remoteaakashclicker DB : "+remoteconnectioncount);
	}
	
	public static void decrementRemoteCount(){
		remoteconnectioncount.decrementAndGet();			
		System.out.println("No of Open Connection after close in clickerv4 at remoteaakashclicker DB : "+remoteconnectioncount);
	}
	public void closeRemoteConnection(Connection con){
		
		try {
			con.close();
			decrementRemoteCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
