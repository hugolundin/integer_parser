#include "munit.h"

extern MunitTest uint8_t_parse_tests[];
extern MunitTest uint16_t_parse_tests[];

static MunitSuite test_suite[] = {{
    .prefix = "",
    .suites = (MunitSuite[]) {
        {
            .prefix = "uint8_t",
            .tests = uint8_t_parse_tests,
            .iterations = 1
        },
        {
            .prefix = "uint16_t",
            .tests = uint16_t_parse_tests,
            .iterations = 1
        },
        {0}
    },
    .iterations = 1,
}};

int main(int argc, char * argv[]) {
    return munit_suite_main(test_suite, NULL, argc, argv);
}
