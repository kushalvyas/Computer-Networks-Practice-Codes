
//CLIENT//

// package client;
import java.lang.System; 
import java.net.*; 
import java.io.*;
 import java.math.*;
public class client { 
 public static void main(String a[]) { 
try 
{ 
// InetAddress addr=InetAddress.getByName("Localhost"); 
// System.out.println(addr); 
Socket connection=new Socket("localhost",1500); 
DataOutputStream out=new DataOutputStream(connection.getOutputStream()); 
BufferedInputStream in=new BufferedInputStream(connection.getInputStream()); 
BufferedInputStream inn=new BufferedInputStream(connection.getInputStream()); 
BufferedReader ki=new BufferedReader(new InputStreamReader(System.in)); 
int flag=0; System.out.println("connect");
 System.out.println("enter the no of frames to be requested to server:"); 
int c=Integer.parseInt(ki.readLine()); 
out.write(c); 
out.flush();
int i,jj=0; 
while (jj<c) 
{ 
i=in.read(); 
System.out.println("received frame no"+i); 
System.out.println("sending acknowledgement for frame no"+i); 
out.write(i); 
out.flush();  
jj++; 
} 
out.flush(); 
in.close(); 
inn.close(); 
out.close();
connection.close(); 
System.out.println("quiting");
 } 
catch (Exception e) 
{ 
System.out.println(e);
}
}
}




