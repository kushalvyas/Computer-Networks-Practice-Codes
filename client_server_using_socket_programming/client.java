import java.io.*;
import java.util.*;
import java.net.*;

/*
	We use import java.net.* .. it contains all the classes related to network and sockets.
 */

class client {

	
	//  main for the client 
	public static void main(String[] args) {
		// declare a socket
		Socket client_socket;
		BufferedReader local, remote;
		PrintStream data_writer;


		try{
			// note : all socket and network requests have to be written in a try - catch block
			client_socket = new Socket("localhost",20000);
			System.out.println("Client Started");
			System.out.println("Enter messages .. \nEnter CTRL+C to close connection");
			local = new BufferedReader(new InputStreamReader(System.in));
			// The local bufferedreader will accept the characters from the user
			remote = new BufferedReader(new InputStreamReader(client_socket.getInputStream()));
			// so client_socket will be receiving data from server... we use remote bufferedreader 
			// to read the data that we receive from server
			data_writer = new PrintStream(client_socket.getOutputStream());
			while(true){
				System.out.println("Please enter a message that you would like to send to the server");
				String localdata = local.readLine();
				data_writer.println(localdata);
				String remotedata = remote.readLine(); // we read if any data has been received from server
				System.out.println("Data reveiced at Client side : " +remotedata);

			}
		}catch(Exception e){
			System.out.println("Exception generated");
			e.printStackTrace();
		}
	}
	
}