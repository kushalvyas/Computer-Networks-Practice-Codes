//PROGRAM FOR SLIDING WINDOW PROTOCOL//
//SERVER//
import java.lang.System;
 import java.net.*;
 import java.io.*; 
public class bitserver {  
public static void main(String[] args) {
 try { 
BufferedInputStream in; 
ServerSocket Serversocket=new ServerSocket(1500); 
System.out.println("waiting for connection");
 Socket client=Serversocket.accept(); 
System.out.println("received request for sending frames"); 
in=new BufferedInputStream(client.getInputStream()); 
DataOutputStream out=new DataOutputStream(client.getOutputStream()); 
int p=in.read(); System.out.println("sending....."); 
for(int i=1;i<=p;++i) 
{ 
System.out.println("sending frame no"+i); 
out.write(i);
out.flush(); 
System.out.println("waiting for acknowledge");
Thread.sleep(5000); int a=in.read(); 
System.out.println("received acknowledge for frame no:"+i+"as"+a);
 } 
out.flush(); 
in.close();
 out.close(); 
client.close();
 Serversocket.close(); 
System.out.println("quiting"); 
} 
catch(IOException e) { 
System.out.println(e); 
} 
catch(InterruptedException e) 
{
}
}
}
