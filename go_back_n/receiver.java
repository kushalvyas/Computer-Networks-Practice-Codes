import java.util.*;
import java.io.*;
import java.net.*;

class receiver {
	public static void main(String[] args) {
		
		
		int Rn = 0;
		System.out.printf("Rn = %d \n",Rn);
	
		
		try{
			// any such procedure has to be written in a try catch
			ServerSocket serversocket = new ServerSocket(2000); // port is 2000
			Socket s = serversocket.accept(); // accept connection from sender
			BufferedReader get_data_from_sender =new BufferedReader(new InputStreamReader(s.getInputStream())); // we will be receiving the response via this
			PrintStream ps = new PrintStream(s.getOutputStream()); // output stream 
			// 
			// listen if the sender wants to send anything
			String senderdata = get_data_from_sender.readLine(); // toh i got the data frm sender
		
			String data_sent = "ACK:0";
			ps.println(data_sent);
			Rn++;

			// normal server is listening
			int flag = 1;
			while(true){
				String data_received = get_data_from_sender.readLine();
				System.out.println("Data obtained : "+data_received);
				// normal working
				if(get_SEQ(data_received)!=0){
					// if valid data is obtained:
					// this again is the normal execution
					Rn ++;
					// lets make a test case that will fail when we get the third letter
					if(Rn == 3 && flag == 1){
						// that is at third character .. we will reset the array
						Rn--; 
						// so it will resend character position @	 3 ..i.e. [0,1,2 ..] 
						flag = 0; // to prevent it from going into infinite loop
					}
					// 
					data_sent = "ACK:"+Integer.toString(Rn);
					ps.println(data_sent);

				}else{
					data_sent = "ACK:"+Integer.toString(Rn);
					ps.println(data_sent);
				}

			}
		}catch(Exception e){
			System.out.println("Exception generated");
		}
	}

	private static int get_SEQ(String data){
		int index = data.indexOf("SEQ:");
		char [] datacopy = data.toCharArray();
		int sq = -1;
		if(index == -1){
			System.out.println("Data is currpoted");
			return 0;
		}else{
			index+=4;
			String text = String.valueOf(datacopy[index]);
			System.out.println(text);
			sq = Integer.parseInt(text);
			return sq;
		}

		
	}
}