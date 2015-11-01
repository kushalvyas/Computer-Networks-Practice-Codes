import java.util.*;
import java.io.*;

class bitstuffing {
	public static void main(String[] args) throws IOException {
		String flag = "01111110";
		System.out.println("Enter the String of message (pleaes enter either 1's and 0's)");
		// take input in buffered readmer
		BufferedReader bfr = new BufferedReader(new InputStreamReader(System.in));
		String message = bfr.readLine();
		// replace DLE flag by DLEDLE
		String finalmessage = message.replaceAll("11111","111110");
		finalmessage = flag + finalmessage +flag;
		System.out.println("Final Character stuffing message is : "+finalmessage);
	}
}