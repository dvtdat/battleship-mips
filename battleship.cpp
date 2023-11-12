#include <bits/stdc++.h>

using namespace std;

int playerA[7][7];
int playerB[7][7];

const int shipSize[6] = {4, 3, 3, 2, 2, 2};
const int nShip = 6;

/*
    for active player:
        - '0': ocean
        - '1': there is ship part at that cell
        - '2': missed shot
        - '3': the ship part there is sunk

    for viewing player:
        - '0': ocean
        - '2': missed shot
        - '3': the ship part there is sunk
*/

void print(int player[7][7], bool toggle) {
    for (int i = 0; i < 7; ++i) {
        for (int j = 0; j < 7; ++j) {
            if (!toggle) {
                if (player[i][j] != 1) cout << player[i][j] << ' ';
                else cout << 0 << ' ';
            }
            else cout << player[i][j];
        }
        cout << '\n';
    }
}

int xA, yA, xB, yB;
int ship;
int x;

int main() {
replay:
    memset(playerA, 0, sizeof playerA);
    memset(playerB, 0, sizeof playerB);

    /* Player A input */
    for (ship = 0; ship < nShip; ++ship) {
    inputA:
        cout << "Player A | Input for ship size " << shipSize[ship] << ": ";
        cin >> xA >> yA >> xB >> yB;
        cout << xA << ' ' << yA << ' ' << xB << ' ' << yB << '\n';

        bool conditionA = (xA < 7 && xB < 7 && yA < 7 && yB < 7 && xA >= 0 && xB >= 0 && yA >= 0 && yB >= 0);
        bool conditionB = (abs(xA + yA - xB - yB) == shipSize[ship] - 1);
        bool conditionC = (xA == xB || yA == yB);

        if (!conditionA || !conditionB || !conditionC) {
            cout << "Wrong input! Input again\n";
            goto inputA;
        }

        if (xA == xB) {
            if (yA > yB) swap(yA, yB);
            for (x = yA; x <= yB; ++x) {
                if (playerA[xA][x]) {
                    cout << "Wrong input! Input again\n";
                    goto inputA;
                }
            }
            for (x = yA; x <= yB; ++x) playerA[xA][x] = 1;
        }

        if (yA == yB) {
            if (xA > xB) swap(xA, xB);
            for (x = xA; x <= xB; ++x) {
                if (playerA[x][yA]) {
                    cout << "Wrong input! Input again\n";
                    goto inputA;
                }
            }
            for (x = xA; x <= xB; ++x) playerA[x][yA] = 1;
        }
        
        print(playerA, true);
    }

    /* Player B input */
    for (ship = 0; ship < nShip; ++ship) {
    inputB:
        cout << "Player B | Input for ship size " << shipSize[ship] << ": ";
        cin >> xA >> yA >> xB >> yB;
        cout << xA << ' ' << yA << ' ' << xB << ' ' << yB << '\n';

        bool conditionA = (xA < 7 && xB < 7 && yA < 7 && yB < 7 && xA >= 0 && xB >= 0 && yA >= 0 && yB >= 0);
        bool conditionB = (abs(xA + yA - xB - yB) == shipSize[ship] - 1);
        bool conditionC = (xA == xB || yA == yB);

        if (!conditionA || !conditionB || !conditionC) {
            cout << "Wrong input! Input again\n";
            goto inputB;
        }

        if (xA == xB) {
            if (yA > yB) swap(yA, yB);
            for (x = yA; x <= yB; ++x) {
                if (playerB[xA][x]) {
                    cout << "Wrong input! Input again\n";
                    goto inputB;
                }
            }
            for (x = yA; x <= yB; ++x) playerB[xA][x] = 1;
        }

        if (yA == yB) {
            if (xA > xB) swap(xA, xB);
            for (x = xA; x <= xB; ++x) {
                if (playerB[x][yA]) {
                    cout << "Wrong input! Input again\n";
                    goto inputB;
                }
            }
            for (x = xA; x <= xB; ++x) playerB[x][yA] = 1;
        }
        
        print(playerB, true);
    }
    
    int toggle = 1;
    int hitCountA = 0;
    int hitCountB = 0;
    int totalStep = 0;

    while (true) {
        totalStep++;
        if (totalStep > 98) break;
    
    turn:
        cout << "Player " << (toggle ? "A" : "B") << " turn: ";
        cin >> xA >> yA;

        bool conditionA = (xA < 7 && yA < 7 && xA >= 0 && yA >= 0);
        if (!conditionA) {
            cout << "False input, please input again\n";
            goto turn;
        }

        if (toggle) {
            bool conditionB = (1 < playerB[xA][yA]);
            if (conditionB) {
                cout << "False input, please input again\n";
                goto turn;
            }

            if (playerB[xA][yA] == 1) cout << "Hit!\n", hitCountA++;
            playerB[xA][yA] += 2;
            print(playerB, false);
        } else {
            bool conditionB = (1 < playerA[xA][yA]);
            if (conditionB) {
                cout << "False input, please input again\n";
                goto turn;
            }

            if (playerA[xA][yA] == 1) cout << "Hit!\n", hitCountB++;
            playerA[xA][yA] += 2;
            print(playerA, false);
        }

        if (hitCountA == 16) {
            cout << "Player A has won!\n";
            goto ending;
        }
        
        if (hitCountB == 16) {
            cout << "Player B has won!\n";
            goto ending;
        }

        toggle = !toggle;
    }
    
ending:
    cout << "The game has ended!\n";
    cout << "Do you want to replay? (Y/N) ";
    char c; cin >> c;
    if (c == 'Y' || c == 'y') goto replay;
}