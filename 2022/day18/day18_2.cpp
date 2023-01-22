//g++ -std=c++11 -O2 -Wall day18_2.cpp -o day18_2
#include<bits/stdc++.h>
#define inf INT_MAX
using namespace std;

set<tuple<int, int, int>> cubes, air_spaces;
int minx = inf, maxx=-inf, miny=inf, maxy=-inf, minz=inf, maxz=-inf;

bool out_of_limits(tuple<int,int,int> t);

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    int x,y,z;
    char c;
    int ans = 0;
    while(cin >> x >> c >> y >> c >> z ){
        minx = min(minx, x);
        miny = min(miny, y);
        minz = min(minz, z);
        maxx = max(maxx, x);
        maxy = max(maxy, y);
        maxz = max(maxz, z);
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
    for(int i=minx; i<=maxx; i++){
        for(int j=miny; j<=maxy; j++){
            for(int k=minz; k<=maxz; k++){
                auto tup = make_tuple(i,j,k);
                if(!cubes.count(tup)) air_spaces.insert(tup);
            }
        }
    }
    int to_discount=0;
    while(!air_spaces.empty()){ 
        auto tup = *air_spaces.begin();
        stack<tuple<int,int,int>> stk;
        set<tuple<int,int,int>> pocket_members;
        stk.push(tup);
        pocket_members.insert(tup);
        bool isAirPocket = true;
        int surface_to_discount = 0;
        while(!stk.empty()){
            tuple<int,int,int> current = stk.top();
            stk.pop();
            vector<tuple<int,int,int>> directions;
            directions.push_back(make_tuple(get<0>(current), get<1>(current), get<2>(current)+1));
            directions.push_back(make_tuple(get<0>(current), get<1>(current), get<2>(current)-1));
            directions.push_back(make_tuple(get<0>(current)+1, get<1>(current), get<2>(current)));
            directions.push_back(make_tuple(get<0>(current)-1, get<1>(current), get<2>(current)));
            directions.push_back(make_tuple(get<0>(current), get<1>(current)+1, get<2>(current)));
            directions.push_back(make_tuple(get<0>(current), get<1>(current)-1, get<2>(current)));
            for(auto dir : directions){
                if(cubes.count(dir)){
                    surface_to_discount++;
                }else if(out_of_limits(dir)){
                    isAirPocket = false;
                }else{
                    if(!pocket_members.count(dir)){
                        pocket_members.insert(dir);
                        stk.push(dir);
                    }
                }
            }
        }
        if(isAirPocket){
            to_discount += surface_to_discount;
        }
        for(auto t :  pocket_members) air_spaces.erase(t);
    }
    cout << ans - to_discount << '\n';
    return 0;
}

bool out_of_limits(tuple<int,int,int> t){
    int x = get<0>(t), y = get<1>(t), z = get<2>(t);
    return x > maxx || x < minx || y > maxy || y < miny || z > maxz || z < minz;
}