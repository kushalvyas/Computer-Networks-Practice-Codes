import java.util.*;
import java.net.*;
import java.io.*;

class server {
	
	public static void main(String[] args) {
		BufferedReader local, remote;
		PrintStream data_writer;
		ServerSocket serversocket;
		Socket socket;

		try{	
			serversocket = new ServerSocket(20000);
			// 2000 is the  port at which i am binding my server connection
			// the client has to connect to this port
			socket = serversocket.accept(); // will accept connection from client
			System.out.println("server started");
			System.out.println("Enter CTRL+C to close connection");
			local = new BufferedReader(new InputStreamReader(System.in));
			// The local bufferedreader will accept the characters from the user
			remote = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			// so serversocket will be sending data to client... we use remote bufferedreader 
			// to read the data that we receive from client
			data_writer = new PrintStream(socket.getOutputStream());

			while(true){
				String remotedata = remote.readLine();
				System.out.println("Data from client : " +remotedata);
				
				System.out.println("Enter message to repond to client");
				String message = local.readLine();
				data_writer.println(message);
				// data_writer.flush();

			}

		}catch(Exception e){
			System.out.println("Exception generated");
			e.printStackTrace();
		}
	}

}