#include<bits/stdc++.h>
#define INF INT_MAX

using namespace std;

int N,M;

int vertexId(int i, int j){
    return i*M + j;
}

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    string l;
    vector <string> m;  
    while( cin >> l){
        m.push_back(l);
    }
    pair<int,int> startPos, endPos;
    N = m.size(); 
    M = m[0].length();

    vector<int> adj[N*M];
    for(int i=0; i<N; i++){
        for(int j=0; j<M; j++){
            if(m[i][j] == 'S') {
                startPos = make_pair(i,j);
                m[i][j] = 'a';
            }
            if(m[i][j] == 'E'){
                endPos = make_pair(i,j);
                m[i][j] = '{';
            }
        }
    }

    for(int i=0; i<N; i++){
        for(int j=0; j<M;j++){
            vector<int> temp;

            if(i != 0 && (m[i-1][j] - m[i][j] <= 1)) temp.push_back(vertexId(i-1,j));
            if(i != N-1 && (m[i+1][j] - m[i][j] <= 1)) temp.push_back(vertexId(i+1,j));
            if(j != 0 && (m[i][j-1] - m[i][j] <= 1)) temp.push_back(vertexId(i,j-1));
            if(j != M-1 && (m[i][j+1] - m[i][j] <= 1)) temp.push_back(vertexId(i,j+1));        

            adj[vertexId(i,j)] = temp;
        }
    }
    priority_queue<pair<int,int>> q;
    int distance[N*M];
    bool processed[N*M];
    int x = vertexId(startPos.first, startPos.second);
    for(int i=0; i<N*M; i++) distance[i] = INF;
    distance[x] = 0;
    q.push({0,x});
    while (!q.empty()) {
        int a = q.top().second; q.pop();
        if (processed[a]) continue;
        processed[a] = true;
        for (auto b : adj[a]) {
            if (distance[a]+1 < distance[b]) {
                distance[b] = distance[a]+1;
                q.push({-distance[b],b});
            }
        }
    }
    //for(auto k : adj[vertexId(endPos.first, endPos.second+2)]) cout << k << '\n';
    //cout << vertexId(startPos.first-1, startPos.second) << '\n';
    //cout << vertexId(startPos.first+1, startPos.second) << '\n';
    //cout << vertexId(endPos.first, endPos.second+1) << '\n';
    // for(int i=0;i<N; i++){
    //     for(int j=0; j<M; j++){
    //         cout << processed[vertexId(i,j)];
    //     }
    //     cout << '\n';
    // }
    //cout << processed[vertexId(endPos.first, endPos.second)] << '\n';
    cout << distance[vertexId(endPos.first, endPos.second)] << '\n';
    return 0;
}