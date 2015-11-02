// dijkstras' algorithm

# include "stdio.h"
# include "stdlib.h"

#define null NULL 
#define infinity 1000

int dist[10],prev[10],Q[10];
int n,i,j,source;
// int weights[10][10];
int u,k;
int weights[9][9] = {{0, 4, 0, 0, 0, 0, 0, 8, 0},
                      {4, 0, 8, 0, 0, 0, 0, 11, 0},
                      {0, 8, 0, 7, 0, 4, 0, 0, 2},
                      {0, 0, 7, 0, 9, 14, 0, 0, 0},
                      {0, 0, 0, 9, 0, 10, 0, 0, 0},
                      {0, 0, 4, 0, 10, 0, 2, 0, 0},
                      {0, 0, 0, 14, 0, 2, 0, 1, 6},
                      {8, 11, 0, 0, 0, 0, 1, 0, 7},
                      {0, 0, 2, 0, 0, 0, 6, 7, 0}
                     };

int Q_is_not_empty(){
	int sum=0;
	for(i=0;i<n;i++){
		sum += Q[i];
	}
	printf("sum is %d\n",sum  );
	return sum;
}

int extract_min(){

	int min=99,min_idx;
	for(i=0;i<n;i++){
		if((dist[i] < min) && (Q[i]== 1) ){
			min = dist[i];
			min_idx=i;
		}
	}
	printf("min extract : %d\n",min);
	Q[min_idx] = 0;
	return min_idx;

}

void print_path(int source , int target){

	if (source == target){
		printf("%d ", source);
	}else{
		printf("%d ", target);
		print_path(source,prev[target]);
	}
	printf("\n");
}

void dijkstra(){

	dist[source] = 0;
	prev[source] = 0;

	for(i=0;i<n;i++){
		if(i!=source){
			dist[i] = infinity;
			prev[i] = 0 ;
		}
		Q[i] = 1; 
	}

	while(Q_is_not_empty()){
		// extract minimum from Q
		for(i=0;i<n;i++){
			printf("%d\t",Q[i] );
		}printf("\n");
		for(i=0;i<n;i++){
			printf("%d\t",dist[i] );
		}

		u = extract_min();

		// for all neighbours of u : 
		// use relaxation
		printf("in while\n");
		for(k=0;k<n;k++){
			printf("Entered if\n");
			if(weights[u][k]!=0 && (u!=k)){

				if (dist[k] > dist[u] + weights[u][k]){
					dist[k] = dist[u] + weights[u][k];
					prev[k] = u;
				}
			}
		}

	}

	// printing final matrix;
	for(i=0;i<n;i++){
		printf("%d\t",dist[i] );
	}printf("\n\n");

}



int main(){
	// printf("Enter number of nodes\n");
	// scanf("%d",&n);
	// printf("Enter adjacevy matrix\n");
	// for(i=0;i<n;i++){
	// 	for(j=0;j<n;j++){
	// 		scanf("%d",&weights[i][j]);
	// 	}
	// }
	
	n = 9;


	printf("Enter source node\n");
	scanf("%d",&source);
	dijkstra();
	for(i=0;i<n;i++){
		printf("source: %d ===> target: %d | Path ==> ",source,i);
		print_path(source,i);
	}
	printf("Path is printed in reverse order ...please edit in ur code. .\n");
	return 0;
}