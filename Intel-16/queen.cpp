#include <iostream>
#include <algorithm>

using namespace std;

const int problem_size = 8;
int A[problem_size+1];
int ans = 0;
int cur = 0;

void print(){
    for(int i=1;i<=problem_size;i++){
        cout << A[i] << " ";
    }
    cout << endl;
}

bool check(){
    for(int i=1;i<cur;i++){
        if(A[i] == A[cur])
            return false;
        int diff = cur - i;
        if(diff == abs(A[cur] - A[i]))
            return false;
    }
    return true;
}

void dfs(){
    cur++;
    if(cur > problem_size){
        print();
        ans++;
    }else{
        for(int i=1;i<=problem_size;i++){
            A[cur] = i;
            if(check())
                dfs();
        }
    }
    cur--;
}

int main(){
    dfs();
    cout << ans << endl;
}
