import java.util.*;
import java.io.*;

class hamming{
	public static void main(String[] args) throws IOException {
		System.out.println("Even parity hamming code");

		BufferedReader bfr = new BufferedReader(new InputStreamReader(System.in));

		System.out.println("Enter the number of parity bits for check : ");
		int b = Integer.parseInt(bfr.readLine());

		// lets create an array storing the parity bits along with data
		/*
			For m parity bits .. the final data string will be of 2^m + m -1 bits
		 */
		double final_length = Math.pow(2,b) - 1;
		int data_length = (int)final_length - b;
		System.out.println("Your final data string will be "+ final_length +" bits");

		System.out.println("Enter the binary message of "+ data_length + " bits");
		String s = bfr.readLine();
		String string = new StringBuffer(s).reverse().toString();
		int length = 0;
		if(string.length() == data_length){
			int [] number = new int[string.length()];
			for(int i=0;i<string.length();i++){
				number[i] = Integer.parseInt(String.valueOf(string.charAt(i)));
			}	
			length = string.length();
			hamming((int)final_length, number ,b);
			
		}else{
			System.out.println("PLease input string as mentioned.");
		}
		
		
		

	}


	private static void hamming(int length, int [] number, int b){
		int [] data = new int [length+1];
		System.out.println(length);
		// init final string
		for(int i=1;i<=b;i++){
			data[(int)Math.pow(2,i-1)] = -1;
		}
		System.out.println(Arrays.toString(data));
		int icount=0,jcount=1;
		while(icount!=number.length){
			if(data[jcount] == -1){
				jcount++;
			}else{
				data[jcount] = number[icount];
				icount++;
				jcount++;
			}

		}
		System.out.println(Arrays.toString(data));

		// now hamming majjaa!!!
		for(int i=1;i<=b;i++){
			// set p[ 2 raised to (i-1) ] as parity value
			// check parity value of string as per parity bit
			int jump = (int)Math.pow(2,i-1);
			int startindex = (int)Math.pow(2,i-1);
			int a = 0;
			for(int j=startindex;j<=length;j+=jump*2){
				for(int k=0;k<jump;k++){
					a+=data[j+k];
				}
			}
			if(a%2 == 0){
				// odd
				data[(int)Math.pow(2,i-1)] = 1;			
			}else{
				data[(int)Math.pow(2,i-1)] = 0;			

			}

		}
		System.out.println("Dont consider the 0th element... It's extra");
		System.out.println("Hamming encoded string");
		for (int i=data.length-1; i>0; i--) {
			System.out.print(data[i]);
		}
		System.out.println();
		// int [] ret = new int[length];
		// return System.arraycopy(data,1,ret, 0,ret.length);

	}



}