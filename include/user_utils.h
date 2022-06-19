#ifndef USER_UTILS
#define USER_UTILS

#include <soci/soci.h>
#include "user.h"

using namespace soci;

class UserUtils {
    public:
        static void fetch_user_by_email(session& sql, User& user);
        static bool verify_user(User& user);       
}

#endif