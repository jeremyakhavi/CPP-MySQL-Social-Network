#include "user.h"
#include <exception>
#include <iostream>
#include <string>

using std::cerr;
using std::cin;
using std::cout;
using std::endl;
using std::exception;
using std::string;

class AppInput {
    enum Options {
        EXIT = 0,
        VIEW_NETWORK,
        VIEW_FOLLOWERS,
        DISPLAY_OPTIONS = 9
    };

    public:
        static void display_opts() {
            cout << endl << "\t 1 - View Network (people you're following)"
                 << endl << "\t 2 - View Followers (people following you)"
                 << endl << "\t 9 - View Input Options"
                 << endl << "\t 0 - Exit" << endl << endl;
        }
        
        static bool process_input() {
            cout << "\t > ";
            int selection = 0;
            cin >> selection;
            cout << "\t You have selected: " << selection << endl;

            switch (selection) {
                case EXIT: {
                    return true;
                    break;
                }
                case VIEW_NETWORK: {
                    cout << "\t You selected view network" << endl;
                    break;
                }
                case VIEW_FOLLOWERS: {
                    cout << "\t You selected view followers" << endl;
                    break;
                }
                case DISPLAY_OPTIONS: {
                    cout << "\t You selected display options" << endl;
                    break;
                }
                default: {
                    cout << "\t Uh oh!" << endl;
                    break;
                }
            }
            return false;
        }
};


int main() {
    try {
        // session sql(mysql, "db=antonibook_db user=dev password=password123");
        AppInput::display_opts();

    }
    catch (const exception& e) {
        cerr << "Exception: " << e.what() << " " << e.what() << endl;
    }
}