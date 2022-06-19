#include "user.h"
#include <iostream>
#include <sstream>

using std::string;
using std::ostringstream;
using std::endl;

const char* User::get_user_string() {
    return user_to_string.c_str();
}

void User::reset() {
    id = 0;
    first_name = last_name = email = "";
    active = false;
}

User::operator const char*() {
    ostringstream oss;
    oss << "ID: " << id << endl
    << "Name: " << first_name << " " << last_name << endl
    << "Email: " << email << endl;

    user_to_string = oss.str();
    return user_to_string.c_str();
}