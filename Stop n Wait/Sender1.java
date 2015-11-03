//Sender1
import java.io.*;
import java.net.*;
public class Sender1
{
	Socket sender;
	ObjectOutputStream out;
	ObjectInputStream in;
	String packet,ack,str, msg;
		int n,i=0,sequence=0;
	Sender1()
	{
		//Constructor 
	}
	public void run()
	{
		try
		{
			BufferedReader br=new BufferedReader(new InputStreamReader(System.in)); 
			System.out.println("Waiting for Connection....");
			sender = new Socket("localhost",2004); 
			sequence=0;
			out=new ObjectOutputStream(sender.getOutputStream());
			out.flush();
			in=new ObjectInputStream(sender.getInputStream());
			str=(String)in.readObject();
			System.out.println("receiver     > "+str);
			System.out.println("Enter the data to send....");
			packet=br.readLine();
			n=packet.length();
			do
			{
				try
				{
					if(i<n)
					{
						msg=String.valueOf(sequence);
						msg=msg.concat(packet.substring(i,i+1));
					}
					else if(i==n)
					{
						msg="end";out.writeObject(msg);break;
					}
					out.writeObject(msg);
					sequence=(sequence==0)?1:0;
					out.flush();
					System.out.println("data sent>"+msg);
					ack=(String)in.readObject();
					System.out.println("waiting for ack.....");
					if(ack.equals(String.valueOf(sequence)))
					{
						i++;
						System.out.println("receiver   >  "+" packet recieved");
					}
					else
					{     
						System.out.println("Time out resending data....");
						sequence=(sequence==0)?1:0;
					}
				}
				catch(Exception e)
				{

				}
			}while(i<n+1);
			System.out.println("All data sent. exiting.");

			in.close();
			out.close();
			sender.close();
		}
		catch(Exception e)
		{

		}
	}
	public static void main(String args[])
	{
		Sender1 s=new Sender1();
		s.run();
	}
}