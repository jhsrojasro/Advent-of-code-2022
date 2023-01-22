//g++ -std=c++11 -O2 -Wall day18_1.cpp -o day18_1
#include<bits/stdc++.h>

using namespace std;

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    int x,y,z;
    char c;
    int ans = 0;
    set<tuple<int, int, int>> cubes;
    while(cin >> x >> c >> y >> c >> z ){
        cubes.insert(make_tuple(x,y,z));
    }
    for(auto t : cubes){
        ans += 1 - cubes.count(make_tuple(get<0>(t)-1,get<1>(t),get<2>(t)));
        ans += 1 - cubes.count(make_tuple(get<0>(t)+1,get<1>(t),get<2>(t)));
        ans += 1 - cubes.count(make_tuple(get<0>(t),get<1>(t)-1,get<2>(t)));
        ans += 1 - cubes.count(make_tuple(get<0>(t),get<1>(t)+1,get<2>(t)));
        ans += 1 - cubes.count(make_tuple(get<0>(t),get<1>(t),get<2>(t)-1));
        ans += 1 - cubes.count(make_tuple(get<0>(t),get<1>(t),get<2>(t)+1));
    }
    cout << ans << '\n';
    return 0;
}