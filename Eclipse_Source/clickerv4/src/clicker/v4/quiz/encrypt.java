package clicker.v4.quiz;

import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Base64;
/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 *
 */
public class encrypt {

	/**
	 * @param args
	 */
	
	
	static int randomDigit(){
		double random = Math.random();
		return (int)(random * 10);
	}
	  
	public  String encrypt1(String msg){
		StringBuffer cipher = new StringBuffer();
		int len = msg.length();		
		double random = Math.random();
		int ival  = ((int)(random * 100)) % 15;		
		cipher.append((char) (randomDigit() + ival + 65));
		cipher.append((char) (len + 64)) ;
		cipher.append((char) (ival + 65));
		for(int i=0;i<len;i++){
			cipher.append((char) (msg.charAt(i)  + ival + 19));	
			cipher.append((char) (randomDigit() + ival + 65));
		}		
		String encryptedText = new String(Base64.encodeBase64(cipher.toString().getBytes()));;
		return encryptedText;
	}
	
  public   String decrypt(String cipher){
		byte[] cipherText = Base64.decodeBase64(cipher.getBytes());
		String decodedbase64 = "";
		try {
			decodedbase64 = new String(cipherText, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		StringBuffer msg = new StringBuffer();
		int len = decodedbase64.length();
		int ival = (decodedbase64.charAt(2) - 65);
		for(int i=3;i<len;i+=2){
			msg.append((char) (decodedbase64.charAt(i) - ival - 19));		
		}		
		return msg.toString();
	}

}
