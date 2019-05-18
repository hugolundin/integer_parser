#include "munit.h"

static MunitSuite test_suite[] = {{
    .prefix = "",
    .suites = (MunitSuite[]) {
        {0}
    },
    .iterations = 1,
}};

int main(int argc, char * argv[]) {
    return munit_suite_main(test_suite, NULL, argc, argv);
}
