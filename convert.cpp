#include <bits/stdc++.h>

using namespace std;

/*
    1. Design sprite and export on .png
    2. Use https://onlinetools.com/image/convert-image-to-hex-codes to convert it to HEX map, paste the result in image.txt
    3. Compile and run convert.cpp
    4. Paste the result in output.txt into battleship.asm
*/

int main() {
    freopen("image.txt", "r", stdin);
    freopen("output.txt", "w", stdout);

    int n, m; cin >> n >> m;

    string color;
    int i = 0, j = 0;

    while (cin >> color) {
        if (i == m) cout << '\n', i = 0;
        i++;
        cout << "0x00" << color.substr(1, (color.back() == ',' ? color.size() - 2 : color.size() - 1)) << ", ";
    }
}