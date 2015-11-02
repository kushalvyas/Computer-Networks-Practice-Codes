import java.util.*;
import java.io.*;

class crc{
	public static void main(String[] args) throws IOException {
		System.out.println("CRC : Sender Side");
		BufferedReader bfr = new BufferedReader(new InputStreamReader(System.in));

		// crc error detection
		System.out.println("Enter the data (dividend) ");
		String data = bfr.readLine();
		System.out.println("Enter the key (divisor) ");
		String key = bfr.readLine();
		int zeros_appended = find_append_zeros(key);
		System.out.println(zeros_appended + " Zeros are to be appended");
		String new_data = appendZero(data, zeros_appended);
		System.out.println("String With Appended Zero : "+new_data);
		int [] divisor = convert_to_int_array(key);
		int [] dividend = convert_to_int_array(new_data);
		int [] set_remainder = divide(dividend, divisor);
		
		int [] encoded_data = new int[dividend.length];
		for(int i=0;i<dividend.length;i++)
			encoded_data[i] = dividend[i];
		for(int i=0;i<zeros_appended;i++)
			encoded_data[dividend.length - i-1] = set_remainder[set_remainder.length-i-1];

		System.out.println("Final array ");
		System.out.println(Arrays.toString(encoded_data));

		// to the user . for CRC correction
		System.out.println("Enter data obtained");
		String dataobtained = bfr.readLine();
		int [] dobt = convert_to_int_array(dataobtained);
		int [] obt_remainder = divide(dobt , divisor);
		for(int i=0;i<obt_remainder.length;i++){
			if(obt_remainder[i]!=0){
				System.out.println("Data is curropted");
				break;
			}
			if(i== obt_remainder.length-1){
				System.out.println("No error in data");
			}
		}
	}

	private static int find_append_zeros(String data){
		int index=-1;
		for(int i=0;i<data.length();i++){
			if(data.charAt(i) == '1'){
				index=data.length() - i -1;
				break;
			}
		}
		return index;
	}

	private static String appendZero(String data, int zeros){
		for (int i=0; i<zeros; i++) {
			data+='0';
		}
		return data;
	}

	private static int [] convert_to_int_array(String x){
		int [] ret = new int[x.length()];
		for(int i=0;i<x.length();i++){
			ret[i] = Character.getNumericValue(x.charAt(i));
		}
		return ret;
	}

	private static int [] divide(int [] dividend, int [] divisor){
		System.out.print("Dividend is ");
		System.out.println(Arrays.toString(dividend));
		System.out.print("Divisor is ");
		System.out.println(Arrays.toString(divisor));


		int iter = dividend.length-divisor.length+1;
		int  [] temp = new int[dividend.length];
		System.arraycopy(dividend,0,temp,0,dividend.length);
		for(int j=0,i=0;j<iter;j++){
			// for(int i=0;i<dividend.length;i++)
			i=j;
			System.out.println("iter : "+i+" j : "+j);	
			if(temp[i]==0){continue;}
			for(int k=0;k<divisor.length;k++,i++){
				temp[i] = temp[i]^divisor[k];
			}
			System.out.println(Arrays.toString(temp));
		}
		System.out.println(Arrays.toString(temp));
				
		return temp;
	}

}