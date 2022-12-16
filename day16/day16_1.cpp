//g++ -std=c++11 -O2 -Wall day16_1.cpp -o day16_1
#include<bits/stdc++.h>
#define INF INT_MAX

using namespace std;

const int n = 55;
const long long one = 1;
map<tuple<int,int,long long>,int> dp;
map<tuple<int,int,long long>,bool> ready;
map<string, int> m;
vector<int> adj[n];
int flow_rates[n];

void solve(int minute, int current_valve, long long valves_open);

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    string s;
    int i=0;
    while(getline(cin, s)){
        string temp = "";
        temp += s[6];
        temp += s[7];
        m[temp] = i++;
    }
    cin.clear();
    freopen("input", "r", stdin);
    for(i = 0; i<n; i++){
        getline(cin, s);
        int j = s.find("="), N = s.length();
        string tempInt = "";
        while(s[j]!=';') tempInt+=s[++j];
        flow_rates[i] = stoi(tempInt);
        j+=25;
        
        while(j < N){
            adj[i].push_back(m[s.substr(j, 2)]);
            j+=4;
        } 
    }
    tuple<int,int,long long> initial_state = make_tuple(0,35,0);
    dp[initial_state] = 0;
    ready[initial_state] = false;
    long long bitmask = 0;

    solve(0,35,bitmask);
    cout << dp.size() << '\n';
    for(auto estado : dp){
        if(get<0>(estado.first)==30){
            int total_pressure_this_minute = 0;
            for(int i = 0; i < n; i++) total_pressure_this_minute += get<2>(estado.first) & (one << i) ? flow_rates[i] : 0;
            cout << estado.second + total_pressure_this_minute << '\n';
        }
    }
    return 0;
}

void solve(int minute, int current_valve, long long valves_open){
    if(minute >= 30) return;
    tuple<int,int,long long> state = make_tuple(minute, current_valve, valves_open); 
    if(ready.count(state) && ready[state]) return;
    ready[state] = true;
    //cout << "ready: (" << get<0>(state) <<  " , " << get<1>(state) <<  " , " << get<2>(state) << ")\n";
    int total_pressure_this_minute = 0;
    for(int i = 0; i < n; i++) total_pressure_this_minute += valves_open & (one << i) ? flow_rates[i] : 0;

    if(!(valves_open & (one << current_valve))){ //We can open the valve
        tuple<int,int,long long> next_state = make_tuple(minute+1, current_valve, valves_open | (one << current_valve));    
        dp[next_state] = dp.count(next_state) ? max(dp[next_state], dp[state] + total_pressure_this_minute) : dp[state] + total_pressure_this_minute;
        solve(minute+1, current_valve, valves_open | (one << current_valve));
    }
    for(auto next_valve: adj[current_valve]){
        tuple<int,int,long long> next_state = make_tuple(minute+1, next_valve, valves_open);
        dp[next_state] = dp.count(next_state) ? max(dp[next_state], dp[state] + total_pressure_this_minute) : dp[state] + total_pressure_this_minute;
        solve(minute+1, next_valve, valves_open);
    }
}