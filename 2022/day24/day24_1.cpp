//g++ -std=c++11 -O2 -Wall day24_1.cpp -o day24_1 && ./day24_1
#include<bits/stdc++.h>
#define INF INT_MAX
using namespace std;

const int n_malloc=110;

vector<string> initial_board;
vector<set<pair<int,int>>> horizontal_blizzards;
vector<set<pair<int,int>>> vertical_blizzards;
int N, M, N_V, M_H, LCM;
long long dp[n_malloc][n_malloc][n_malloc][n_malloc];
bool visited[n_malloc][n_malloc][n_malloc][n_malloc];
bool ready[n_malloc][n_malloc][n_malloc][n_malloc];
long long solve(int i, int j, int n, int m);
int gcd(int a, int b) ;
long long calls=0;


int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    string s;
    while(cin >> s) initial_board.push_back(s);
    //for(auto s_ : initial_board) cout << s_ + "\n";
    N = (int)initial_board.size(); M = (int)initial_board[0].size();
    N_V = N-2; M_H = M - 2;
    LCM = N_V * M_H / gcd(M_H, N_V);
    vector<pair<int,int>> left_blizzards;
    vector<pair<int,int>> right_blizzards;
    vector<pair<int,int>> up_blizzards;
    vector<pair<int,int>> down_blizzards;
    for(int i=0; i<N; i++){
        for(int j=0; j<M; j++){
            if(initial_board[i][j] == '<') left_blizzards.push_back(make_pair(i,j));
            if(initial_board[i][j] == '>') right_blizzards.push_back(make_pair(i,j));
            if(initial_board[i][j] == '^') up_blizzards.push_back(make_pair(i,j));
            if(initial_board[i][j] == 'v') down_blizzards.push_back(make_pair(i,j));
        }
    }
    
    for(int j=0; j<M_H; j++){
        set<pair<int,int>> temp_j;
        horizontal_blizzards.push_back(temp_j);
        int next_m;
        for(auto left_blizzard : left_blizzards){
            next_m = left_blizzard.second - j < 1 ? left_blizzard.second - j + M_H : left_blizzard.second - j;
            horizontal_blizzards[j].insert(make_pair(left_blizzard.first, next_m));
        }
        for(auto right_blizzard : right_blizzards){
            next_m = right_blizzard.second + j > M_H ? right_blizzard.second + j - M_H : right_blizzard.second + j;
            horizontal_blizzards[j].insert(make_pair(right_blizzard.first, next_m));
        }
    }
    for(int i=0; i<N_V; i++){
        set<pair<int,int>> temp_i;
        vertical_blizzards.push_back(temp_i);
        int next_n;
        for(auto up_blizzard : up_blizzards){
            next_n = up_blizzard.first - i < 1 ? N_V + up_blizzard.first - i : up_blizzard.first - i;
            vertical_blizzards[i].insert(make_pair(next_n, up_blizzard.second));
        } 
        for(auto down_blizzard : down_blizzards){
            next_n = down_blizzard.first + i > N_V ? down_blizzard.first + i - N_V  : down_blizzard.first + i;
            vertical_blizzards[i].insert(make_pair(next_n, down_blizzard.second));
        }
    }
    
    for(int i=0; i<N; i++){
        for(int j=0; j<M; j++){
            for(int n=0; n<N_V; n++){
                for(int m=0; m<M_H; m++){
                    dp[i][j][n][m] = INF;
                    visited[i][j][n][m] = false;
                    ready[i][j][n][m] = false;
                    
                }
            }
        }
    }
    cout << solve(0,1,0,0) << '\n';
    return 0;
}

long long solve(int i, int j, int n, int m){
    if(i == N-1 && j == M_H) return 0; //GOAL
    if((i == 0 && j!=1) || (i==N-1 && j!=M_H) || j==0 || j == M-1) return INF; // '#' cells
    pair<int,int> current_pos = make_pair(i,j);
    if(horizontal_blizzards[m].count(current_pos) || vertical_blizzards[n].count(current_pos)) return INF; //unreacheble state
    if(ready[i][j][n][m]) return dp[i][j][n][m]; //Already computed state
    if(visited[i][j][n][m]) return INF;
    //procces state
    visited[i][j][n][m] = true;
    long long min_value = INF;
    int next_n = (n+1)%N_V, next_m = (m+1)%M_H;
    // pair<int,int> up = make_pair(i-1,j);
    // pair<int,int> down = make_pair(i+1,j);
    // pair<int,int> left = make_pair(i,j-1);
    // pair<int,int> right = make_pair(i,j+1);

    if(i<N-1) min_value = min(min_value, 1 + solve(i+1,j,next_n, next_m)); //go down
    if(j<M_H) min_value = min(min_value, 1 + solve(i,j+1, next_n, next_m)); // go right
    min_value = min(min_value, 1 + solve(i,j,next_n, next_m)); //Stay
    if(j>1) min_value = min(min_value, 1 + solve(i,j-1,next_n, next_m)); //go left
    if(i>0) min_value = min(min_value, 1 + solve(i-1,j,next_n, next_m)); //go up
    dp[i][j][n][m] = min_value; //update state
    ready[i][j][n][m] = true;
    return dp[i][j][n][m];
}

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a%b);
}