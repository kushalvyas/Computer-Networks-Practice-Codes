import java.util.*;
import java.io.*;

class charstuffing {
	public static void main(String[] args) throws IOException {
	
		System.out.println("Enter the String of message (pleaes enter all capital letters)");
		// take input in buffered readmer
		BufferedReader bfr = new BufferedReader(new InputStreamReader(System.in));
		String message = bfr.readLine();
		// replace DLE flag by DLEDLE
		String finalmessage = message.replaceAll("DLE","DLEDLE");
		finalmessage = "DLESTX" + finalmessage +"DLEETX";
		System.out.println("Final Character stuffing message is : "+finalmessage);
	}
}
