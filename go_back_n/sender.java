import java.util.*;
import java.io.*;
import java.net.*;

class sender {
	public static void main(String[] args) {
		
		String m = "ABCDEFGHI";
		char [] message = m.toCharArray();
		System.out.print("Original message is :");
		System.out.println(message);
		int Sb = 0;
		int Sn = 0;
		int Sm = message.length;
			System.out.printf("Sb = %d and Sm = %d\n",Sb,Sm);
		// initiate connection to the receiver
		// so lets create a socket
		
		try{
			// any such procedure has to be written in a try catch
			Socket sendersocket = new Socket("localhost",2000); // port is 2000
			BufferedReader get_data_from_receiver =new BufferedReader(new InputStreamReader(sendersocket.getInputStream())); // we will be receiving the response via this
			PrintStream ps = new PrintStream(sendersocket.getOutputStream()); // output stream 
			// 
			// first we send the first char of the message array 
			String tobesent = "I want to connect with you";
			ps.println(tobesent);
			// now await for the response
			String response_from_receiver = get_data_from_receiver.readLine();
			int request_no = get_ACK(response_from_receiver);
			while(true){
				if(request_no >= Sb){
					Sm = Sm +(request_no - Sb);
					Sb = request_no;
					String sequence_no_string = Integer.toString(Sb);
					String data_to_be_sent = message[Sb]+"SEQ:"+sequence_no_string;
					System.out.println("Data sent to server is : "+data_to_be_sent);
					ps.println(data_to_be_sent);
					// receive the response
					response_from_receiver = get_data_from_receiver.readLine();
					request_no = get_ACK(response_from_receiver);

				}

			}
			
		}catch(Exception e){
			System.out.println("Exception generated");
		}
	}


	private static int get_ACK(String data){
		int startindex = data.indexOf("ACK:");
		char [] datacopy = data.toCharArray();
		int request_no = -1;
		if(startindex == -1){
			System.out.println("Data is currpoted");

		}else{
			startindex+=4;
			String text = String.valueOf(datacopy[startindex]);
			System.out.println(text);
			request_no = Integer.parseInt(text);
		}

		return request_no;
	}
}