//g++ -std=c++11 -O2 -Wall day17_2.cpp -o day17_2
#include<bits/stdc++.h>

using namespace std;

const int HORIZONTAL = 0;
const int CROSS = 1;
const int L = 2;
const int VERTICAL = 3; 
const int SQUARE = 4;

vector<string> chamber;
string jet_pattern;
int index_jet;
int index_rock;
pair<int, int> lm; //coordinates of the Left Most Block of current Rock
int rock_count = 0;
int top_most;
long long preserverd_lines = 1000;
long long lines_limit = 1000000;
long long cleans_count;


void add_rock();
void add_empty_lines(int n);
void move_rock_to_side();
bool move_rock_down();
void printChamber();
void update_top_most();
void process_move();
void clean_memory();

int main(){
    ios::sync_with_stdio(0);
    cin.tie(0);
    freopen("input", "r", stdin);
    cin >> jet_pattern;
    index_rock = 0;
    top_most = 0;
    index_jet = 0;
    cleans_count = 0;
    for(long long i=0; i<100000000; i++){
        //if(i%100000000000==0) cout << "xd"<< '\n';
        //if(!chamber.empty() && i % lines_limit == 0)
        process_move();
        if(index_rock==0 && index_jet==0){
        cout << "top_most: "<< top_most << " with "<< rock_count << '\n';
    }
    } 
    //cout << xd << '\n';
    return 0;
}

void process_move(){
    int emtpy_lines = max(0, (int)chamber.size() - top_most -1);
    if(emtpy_lines> 3){
        for(int i=0; i < emtpy_lines - 3; i++) chamber.pop_back();
    }else if(emtpy_lines < 3){
        add_empty_lines(3 - (emtpy_lines));
    }
    add_rock();
    while(true){
        move_rock_to_side(); 
        if(!move_rock_down()){
            break;
        }
    }
    update_top_most();
    index_rock = (index_rock + 1) % 5;
    rock_count+=1;
}

void clean_memory(){
    vector<string> temp;
    for(int i=0; i<preserverd_lines; i++){
        temp.push_back(chamber[chamber.size() -1 -i]);
    }
    chamber.clear();
    chamber = temp;
    temp.clear();
    top_most -= lines_limit - preserverd_lines;
    cleans_count++;
}
void add_rock(){
    lm.second = 2;
    if(index_rock == HORIZONTAL){
        lm.first = chamber.size();
        chamber.push_back("..####.");
    }else if(index_rock == CROSS){
        lm.first = chamber.size()+1;
        chamber.push_back("...#...");
        chamber.push_back("..###..");
        chamber.push_back("...#...");
    }else if(index_rock == L){
        lm.first = chamber.size();
        chamber.push_back("..###..");
        chamber.push_back("....#..");
        chamber.push_back("....#..");
    }else if(index_rock == VERTICAL){
        lm.first = chamber.size()+3;
        for(int i=0; i<4; i++) chamber.push_back("..#....");
    }else{
        lm.first = chamber.size()+1;
        chamber.push_back("..##...");
        chamber.push_back("..##...");
    }
}

void add_empty_lines(int n){
    for(int i=0; i<n; i++) chamber.push_back(".......");
}

void move_rock_to_side(){
    if(index_rock == HORIZONTAL){
        if(jet_pattern[index_jet] == '>'){
            if(lm.second + 4 < 7 && chamber[lm.first][lm.second+4] == '.'){
                chamber[lm.first][lm.second] = '.';
                chamber[lm.first][lm.second + 4] = '#';
                lm.second += 1;
            }
        }else{
            if(lm.second - 1 >= 0 && chamber[lm.first][lm.second-1] == '.'){
                chamber[lm.first][lm.second-1] = '#';
                chamber[lm.first][lm.second+3] = '.';
                lm.second -= 1;
            }
        }
    }else if(index_rock == CROSS){
        if(jet_pattern[index_jet] == '>'){
            if(lm.second +3 < 7 
            && chamber[lm.first][lm.second+3]=='.' 
            && chamber[lm.first-1][lm.second+2] == '.' 
            && chamber[lm.first+1][lm.second+2] == '.'){
                chamber[lm.first][lm.second]='.';
                chamber[lm.first-1][lm.second+1]='.';
                chamber[lm.first+1][lm.second+1]='.';
                chamber[lm.first-1][lm.second+2]='#';
                chamber[lm.first+1][lm.second+2]='#';
                chamber[lm.first][lm.second+3]='#';
                lm.second += 1;
            }
        }else{
            if(lm.second -1 >= 0
            && chamber[lm.first][lm.second-1] == '.'
            && chamber[lm.first-1][lm.second] == '.'
            && chamber[lm.first+1][lm.second] == '.'){
                chamber[lm.first][lm.second-1]='#';
                chamber[lm.first-1][lm.second]='#';
                chamber[lm.first+1][lm.second]='#';
                chamber[lm.first-1][lm.second+1]='.';
                chamber[lm.first+1][lm.second+1]='.';
                chamber[lm.first][lm.second+2] = '.';
                lm.second -= 1;
            }
        }
    }else if(index_rock == L){
        if(jet_pattern[index_jet] == '>'){
            if(lm.second +3 < 7
            && chamber[lm.first][lm.second+3]=='.'
            && chamber[lm.first+1][lm.second+3]=='.'
            && chamber[lm.first+2][lm.second+3]=='.'){
                chamber[lm.first][lm.second] = '.';
                chamber[lm.first+1][lm.second+2] = '.';
                chamber[lm.first+2][lm.second+2] = '.';
                chamber[lm.first][lm.second+3] = '#';
                chamber[lm.first+1][lm.second+3] = '#';
                chamber[lm.first+2][lm.second+3] = '#';
                lm.second += 1;
            }
        }else{
            if(lm.second -1 >= 0
            && chamber[lm.first][lm.second-1]=='.'
            && chamber[lm.first+1][lm.second+1] == '.'
            && chamber[lm.first+2][lm.second+1]=='.'){
                chamber[lm.first][lm.second+2] = '.';
                chamber[lm.first+1][lm.second+2] = '.';
                chamber[lm.first+2][lm.second+2] = '.';
                chamber[lm.first+1][lm.second+1] = '#';
                chamber[lm.first+2][lm.second+1] = '#';
                chamber[lm.first][lm.second-1] = '#';
                lm.second -= 1;
            }
        }
    }else if(index_rock == VERTICAL){
        if(jet_pattern[index_jet] == '>'){
            if(lm.second +1 < 7
            && chamber[lm.first][lm.second+1]=='.'
            && chamber[lm.first-1][lm.second+1]=='.'
            && chamber[lm.first-2][lm.second+1]=='.'
            && chamber[lm.first-3][lm.second+1]=='.'){
                chamber[lm.first][lm.second]='.';
                chamber[lm.first-1][lm.second]='.';
                chamber[lm.first-2][lm.second]='.';
                chamber[lm.first-3][lm.second]='.';
                chamber[lm.first][lm.second+1]='#';
                chamber[lm.first-1][lm.second+1]='#';
                chamber[lm.first-2][lm.second+1]='#';
                chamber[lm.first-3][lm.second+1]='#';
                lm.second += 1;
            }
        }else{
            if(lm.second -1 >= 0
            && chamber[lm.first][lm.second-1]=='.'
            && chamber[lm.first-1][lm.second-1]=='.'
            && chamber[lm.first-2][lm.second-1]=='.'
            && chamber[lm.first-3][lm.second-1]=='.'){
                chamber[lm.first][lm.second]='.';
                chamber[lm.first-1][lm.second]='.';
                chamber[lm.first-2][lm.second]='.';
                chamber[lm.first-3][lm.second]='.';
                chamber[lm.first][lm.second-1]='#';
                chamber[lm.first-1][lm.second-1]='#';
                chamber[lm.first-2][lm.second-1]='#';
                chamber[lm.first-3][lm.second-1]='#';
                lm.second -= 1;
            }
        }
    }else{
        if(jet_pattern[index_jet] == '>'){
            if(lm.second +2 < 7
            && chamber[lm.first][lm.second+2]=='.'
            && chamber[lm.first-1][lm.second+2]=='.'){
                chamber[lm.first][lm.second] = '.';
                chamber[lm.first-1][lm.second] = '.';
                chamber[lm.first][lm.second+2] = '#';
                chamber[lm.first-1][lm.second+2] = '#';
                lm.second += 1;
            }
        }else{
            if( lm.second -1 >= 0
            && chamber[lm.first][lm.second-1]=='.'
            && chamber[lm.first-1][lm.second-1]=='.'){
                chamber[lm.first][lm.second+1] = '.';
                chamber[lm.first-1][lm.second+1] = '.';
                chamber[lm.first][lm.second-1] = '#';
                chamber[lm.first-1][lm.second-1] = '#';
                lm.second -= 1;
            }
        }
    }
    index_jet = (index_jet + 1) % jet_pattern.length(); 
}

bool move_rock_down(){
    if(index_rock == HORIZONTAL){
        if(lm.first - 1 >= 0
        && chamber[lm.first-1][lm.second] == '.'
        && chamber[lm.first-1][lm.second+1] == '.'
        && chamber[lm.first-1][lm.second+2] == '.'
        && chamber[lm.first-1][lm.second+3] == '.'){
            chamber[lm.first][lm.second] = '.';
            chamber[lm.first][lm.second+1] = '.';
            chamber[lm.first][lm.second+2] = '.';
            chamber[lm.first][lm.second+3] = '.';
            chamber[lm.first-1][lm.second] = '#';
            chamber[lm.first-1][lm.second+1] = '#';
            chamber[lm.first-1][lm.second+2] = '#';
            chamber[lm.first-1][lm.second+3] = '#';
            lm.first -= 1;
            return true;
        }
    }else if(index_rock == CROSS){
        if(lm.first -2 >= 0
        && chamber[lm.first-2][lm.second+1] == '.'
        && chamber[lm.first-1][lm.second] == '.'
        && chamber[lm.first-1][lm.second+2] == '.'){
            chamber[lm.first][lm.second] = '.';
            chamber[lm.first][lm.second+2] = '.';
            chamber[lm.first+1][lm.second+1] = '.';
            chamber[lm.first-2][lm.second+1] = '#';    
            chamber[lm.first-1][lm.second] = '#';    
            chamber[lm.first-1][lm.second+2] = '#';  
            lm.first-=1;
            return true;  
        }
    }else if(index_rock == L){
        if(lm.first -1 >= 0
        && chamber[lm.first-1][lm.second] == '.'
        && chamber[lm.first-1][lm.second+1] == '.'
        && chamber[lm.first-1][lm.second+2] == '.'){
            chamber[lm.first][lm.second] = '.';
            chamber[lm.first][lm.second+1] = '.';
            chamber[lm.first+2][lm.second+2] = '.';
            chamber[lm.first-1][lm.second] = '#';
            chamber[lm.first-1][lm.second+1] = '#';
            chamber[lm.first-1][lm.second+2] = '#';
            lm.first-=1;
            return true;
        }
    }else if(index_rock == VERTICAL){
        if(lm.first -4 >= 0 && chamber[lm.first-4][lm.second] == '.'){
            chamber[lm.first][lm.second] = '.';
            chamber[lm.first-4][lm.second] = '#';
            lm.first-=1;
            return true;
        }
    }else{
        if(lm.first -2 >= 0
        && chamber[lm.first-2][lm.second] == '.'
        && chamber[lm.first-2][lm.second+1] == '.'){
            chamber[lm.first][lm.second] = '.';
            chamber[lm.first][lm.second+1] = '.';
            chamber[lm.first-2][lm.second] = '#';
            chamber[lm.first-2][lm.second+1] = '#';
            lm.first-=1;
            return true;
        }
    }
    return false;
}

void update_top_most(){
    if(index_rock == CROSS){
        top_most = max(top_most, lm.first+1);
    }else if(index_rock == L){
        top_most = max(top_most, lm.first+2);
    }else{
        top_most = max(top_most, lm.first);
    }
}

void printChamber(){
    for(int i = chamber.size()-1; i>=0; i--) cout << chamber[i] << '\n';
    cout << '\n';
}