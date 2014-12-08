/*
 * Author  : Dipti , Kirti  from Clicker Team, IDL LAB -IIT Bombay
 * This file used for sending user a random temporary password through gmail.
 */

package clicker.v4.login;


import java.util.Properties;
import java.util.Random;

import javax.mail.*;
import javax.mail.internet.*;


public class SendMailForForgotPassword {
// This function generates the random temporary password to send it to user if in case user forgets password .
public static String generatePassword(){
	
	char[] chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz".toCharArray();
	StringBuilder sb = new StringBuilder();
	Random random = new Random();
	for (int i = 0; i < 7; i++) {
	    char c = chars[random.nextInt(chars.length)];
	    sb.append(c);
	}
	String output = sb.toString();
	return output;
	
}
	
// This function is used for sending temporary password to user through Gmail in local mode. 
//It takes the Gmail username and password of admin from database to send that random password to user's gmail.	
 public String emailmain(String emailto, String instrname) {
	 String sendStatus="NotSend";
loginHelper loginhelp = new loginHelper();
final String emailfrom = loginhelp.getEmail();
final String passwordfrom = loginhelp.getPassword();

 String to =emailto;//change accordingly
 Properties props = new Properties();
 props.put("mail.smtp.auth", "true");
 props.put("mail.smtp.starttls.enable", "true");
 props.put("mail.smtp.host", "smtp.gmail.com");
 props.put("mail.smtp.port", "587");
 
  Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
   protected PasswordAuthentication getPasswordAuthentication() {
   return new PasswordAuthentication(emailfrom,passwordfrom);//change accordingly
   }
  });
 
//compose message
  try {
   MimeMessage message = new MimeMessage(session);
   String username = instrname;
      
   System.out.println("sending email from: b "+emailfrom);
   System.out.println("sending password from: b "+passwordfrom);
   message.setFrom(new InternetAddress(emailfrom));//change accordingly
   message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
   message.setSubject("Reg:Clickerv4admin : Update your password ");
   String temppswd = generatePassword();
   System.out.println("!!!!!!!!!!!!!!!!! temppswd is: "+temppswd);
   message.setText("Hello sir/madam," +
   		"\n\n We are sending you temporary password for clicker login. You can now login using this password, but you have to change it immediately after login. \n" +
		   "To change password, go to Admin menu and select Change Password."+
   		"\n\n Thank you !" +"\n\n\n Your temporary password is : \t"+temppswd);
   System.out.println("message sending");
   //send message
	try
	{
		
		Transport.send(message);
		sendStatus="Send";
		System.out.println("message sent successfully");
		loginhelp.updatePassword(username,temppswd);
	}
	catch (MessagingException e){
		
			sendStatus="NotSend";
			System.out.print("Could not connect to SMTP host: smtp.gmail.com, port: 587;");
			
		}

} catch (MessagingException e) {
	sendStatus="NotSend";
	System.out.print("Could not connect to SMTP host: smtp.gmail.com, port: 587; OR Network problem");
	
	}
		return sendStatus;
 }
 
 
//This function is used for sending temporary password to user through Gmail in remote mode. 
//It takes the Gmail username and password of admin from database to send that random password to user's gmail.	 
 
 public String remoteemailmain(String emailto, String instrname) {
String sendStatus="NotSend";
loginHelper loginhelp = new loginHelper();
final String emailfrom = loginhelp.remotegetEmail();
final String passwordfrom = loginhelp.remotegetPassword();

String to =emailto;//change accordingly
Properties props = new Properties();
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
 
  Session session = Session.getDefaultInstance(props,
   new javax.mail.Authenticator() {
   protected PasswordAuthentication getPasswordAuthentication() {
   return new PasswordAuthentication(emailfrom,passwordfrom);//change accordingly
   }
  });
 
//compose message
  try {
   MimeMessage message = new MimeMessage(session);
   String username = instrname;
      
   System.out.println("sending email from: b "+emailfrom);
   message.setFrom(new InternetAddress(emailfrom));//change accordingly
   message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
   message.setSubject("Reg:Clickerv4admin : Update your password ");
   String temppswd = generatePassword();
   System.out.println("!!!!!!!!!!!!!!!!! temppswd is: "+temppswd);
   message.setText("Hello sir/madam," +
   		"\n\n We are sending you temporary password for clicker login. You can now login using this password, but you have to change it immediately after login. \n" +
		   "To change password, go to Admin menu and select Change Password."+
   		"\n\n Thank you !" +"\n\n\n Your temporary password is : \t"+temppswd);
   
 //send message
 	try
 	{
 		
 		Transport.send(message);
 		sendStatus="Send";
 		System.out.println("message sent successfully");
 		loginhelp.updatePassword(username,temppswd);
 	}
 	catch (MessagingException e){
 		
 			sendStatus="NotSend";
 			System.out.print("Could not connect to SMTP host: smtp.gmail.com, port: 587;");
 			
 		}

 } catch (MessagingException e) {
 	sendStatus="NotSend";
 	System.out.print("Could not connect to SMTP host: smtp.gmail.com, port: 587; OR Network problem");
 	
 	}
 		return sendStatus;
 }
}

