

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;

public class Main {
	
	public static void GenGrid (String grid) {

		String[] gridArray = grid.split(";");
		
		//grid size
		int m = Integer.parseInt(gridArray[0].split(",")[0]);
		int n = Integer.parseInt(gridArray[0].split(",")[1]);
		
		//iron man position
		int ix = Integer.parseInt(gridArray[1].split(",")[0]);
		int iy = Integer.parseInt(gridArray[1].split(",")[1]);
		
		//thanos position
		int tx = Integer.parseInt(gridArray[2].split(",")[0]);
		int ty = Integer.parseInt(gridArray[2].split(",")[1]);
		
		//linkedlist of stones
		int [] stones = new int [8];

		int s;
		String[]stonesArray = gridArray[3].split(",");
		for(int i=0; i < stonesArray.length; i+=1) {
			s = Integer.parseInt(stonesArray[i]);
			stones[i] = s;
		}
		
		
		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter("kB.pl"));
			writer.write("grid("+m+","+n+"). \n");
			writer.write("iMan(" + ix + "," + iy + ",s0). \n");
			writer.write("thanos(" + tx + "," + ty + "). \n");
			for(int i=0; i < stones.length-1; i+=2)
				writer.write("isStone(" + stones[i] + "," + stones[i+1] + ",s0). \n");
			writer.close();
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	
	
	public static void main(String [] args) {
		
		
		GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3");
		
	}
	
	
	
	
	
	
	
	
	

}
