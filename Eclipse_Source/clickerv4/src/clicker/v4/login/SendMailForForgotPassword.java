/*
 * Author  : Dipti  from Clicker Team, IDL LAB -IIT Bombay
 */

package clicker.v4.login;


import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;


public class SendMailForForgotPassword {

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
	
	
 public void emailmain(String emailto, String instrname) {

loginHelper loginhelp = new loginHelper();
final String emailfrom = loginhelp.getEmail();
final String passwordfrom = loginhelp.getPassword();

 String to =emailto;//change accordingly
 Properties props = new Properties();
  props.put("mail.smtp.host", "smtp.gmail.com");
  props.put("mail.smtp.socketFactory.port", "465");
  props.put("mail.smtp.socketFactory.class",
        	"javax.net.ssl.SSLSocketFactory");
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.port", "465");
 
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
   Transport.send(message);
   System.out.println("message sent successfully");
   loginhelp.updatePassword(username,temppswd);
 
 
  } catch (MessagingException e) {throw new RuntimeException(e);}
 
 }
 
 
 
 
 public void remoteemailmain(String emailto, String instrname) {

loginHelper loginhelp = new loginHelper();
final String emailfrom = loginhelp.remotegetEmail();
final String passwordfrom = loginhelp.remotegetPassword();

 String to =emailto;//change accordingly
 Properties props = new Properties();
  props.put("mail.smtp.host", "smtp.gmail.com");
  props.put("mail.smtp.socketFactory.port", "465");
  props.put("mail.smtp.socketFactory.class",
        	"javax.net.ssl.SSLSocketFactory");
  props.put("mail.smtp.auth", "true");
  props.put("mail.smtp.port", "465");
 
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
   Transport.send(message);
   System.out.println("message sent successfully");
   loginhelp.remoteupdatePassword(username,temppswd);
 
 
  } catch (MessagingException e) {throw new RuntimeException(e);}
 
 }
 
}

