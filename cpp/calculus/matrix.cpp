#include <vector>
using namespace std;

#define N 500

void multiply(const vector<vector<double>>& a, const vector<vector<double>>& b, vector<vector<double>>& result) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            result[i][j] = 0.0;
            for (int k = 0; k < N; k++) {
                result[i][j] += a[i][k] * b[k][j];
            }
        }
    }
}

int main() {
    vector<vector<double>> a(N, vector<double>(N));
    vector<vector<double>> b(N, vector<double>(N));
    vector<vector<double>> result(N, vector<double>(N));

    return 0;
}
