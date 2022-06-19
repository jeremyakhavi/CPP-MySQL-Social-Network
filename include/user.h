#ifndef USER_H
#define USER_H

#include <string>

using std::string;
using std::ostringstream;

class User {
    public:
        int id;
        string first_name;
        string last_name;
        string email;
        int active;

    private:
        string user_to_string;

    public:
        const char* get_user_string();
        void reset();
        // overload const char* operator so we can pipe User to cout
        explicit operator const char*();
};

#endif