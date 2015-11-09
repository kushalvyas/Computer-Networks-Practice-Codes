import java.io.*;
import java.util.*;

//Wiki-Hamming code
public class Hamming{
	public static void main(String args[])throws IOException
	{
		//Considering even parity
		BufferedReader bfr = new BufferedReader(new InputStreamReader(System.in));
		System.out.print("Enter number of parity bits: ");
		int m_bits = Integer.parseInt(bfr.readLine());
		int total_bits = (int) (Math.pow(2, m_bits) -1);
		int data_bits = total_bits -m_bits;
		System.out.print("Enter data of "+data_bits+" bits(LSB first):  ");
		String data_str = bfr.readLine();
		
		hamming(m_bits, total_bits, data_bits, data_str);
		
		//Error Detection 
		System.out.println("Enter encoded hamming code to decode(p1 p2 d1 p3 d2 and so on):");
		String hamm_str = bfr.readLine();
		detect(m_bits, total_bits, hamm_str);
		
	}

	private static void detect(int m_bits, int total_bits, String hamm_str) {
		// TODO Auto-generated method stub
		int i, j, k, check, start, jump;
		int error[] = new int[m_bits];
		int code[] = new int[total_bits+1];
		for(i = 0; i < total_bits; i++){
			code[i+1] = Integer.parseInt(""+hamm_str.charAt(i));
		}
		for(i = 0; i < m_bits; i++){
			start = (int)Math.pow(2,i);
			jump = (int)Math.pow(2,i);
			check = 0;
			for(j = start; j <= total_bits; j += (jump + jump)){
				for(k = 0; k < jump; k++){
					check += code[j+k];
				}
			}
				if(check % 2 == 0){//parity is even so no error for p(i)
					error[i] = 0;
				}
				else{//Error for parity bit p(i)
					error[i] = 1;
				}
				
			
		}
		int error_position = 0;
		for(i = 0; i < m_bits; i++){//Binary to decimal conversion
			error_position+= ((int)Math.pow(2, i) * error[i]);
		}
		if(error_position == 0){
			System.out.println("No error");
		}
		else{
			System.out.println("Error at position "+error_position);
		}
			
		
	}

	private static void hamming(int m_bits, int total_bits, int data_bits,
			String data_str) {
		int i, j, k, start, step, check;
		int code[] = new int[total_bits+1];//transmitted code, added 1 for 1-indexing
		for(i = 0; i < m_bits; i++)
		{
			code[(int)Math.pow(2,i)] = -1; //Marking parity bits places
		}
		
		//Adding data bits into transmitted code array
		for(i = 1, j=0; i <= total_bits; i++)//Remember 1-indexing not 0-indexing
		{
			if(code[i] == -1){//Place of parity bit
				code[i] = 0;//Unmarking parity place because we will need this later
			}
			else{//Place of data bit in transmitted code
				code[i] = Integer.parseInt(""+data_str.charAt(j));
				//Integer.parseInt takes string as a parameter not char hence ""+
				j++;
			}
		}
		for(i=0; i < m_bits; i++){
			start = (int)Math.pow(2,i);
			step = (int)Math.pow(2,i);
			check = 0;
			for(j = start; j <= total_bits; j += (step + step)){
				for(k = 0; k < step; k++)
				{
					check += code[j+k];
				}
			}
				if(check % 2 == 0){//Even parity without parity bit so parity bit will remain 0
					code[start] = 0;
				}
				else{//Now parity with parity bit is even
					code[start] = 1;
				}
				
			
		}
		//DISPLAY
		for(i = 1; i <= data_bits; i++){
			System.out.print("d"+i+"\t");
		}
		System.out.println();
		for(i = 0; i < data_bits; i++){
			System.out.print(data_str.charAt(i)+"\t");
		}
		System.out.println("Hamming encoded string");
		for(i = 1, j = 1, k = 1; i <= total_bits; i++){
			if((int)Math.pow(2, j-1) == i){
				System.out.print("p"+j+"\t");
				j++;
			}
			else{
				System.out.print("d"+k+"\t");
				k++;
			}			
		}
		System.out.println();
		for(i = 1; i<=total_bits; i++){
			System.out.print(code[i]+"\t");
		}
		System.out.println();

	}

}
