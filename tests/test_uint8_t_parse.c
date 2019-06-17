#include "munit.h"

#include "integer_parser.h"

static MunitResult test_parse_valid(const MunitParameter params[], void * data)
{
    int ret = 0;
    uint8_t result = 0;
    char const * const number = "8";
    
    ret = uint8_t_parse(
        /* buf = */ number,
        /* buf_len = */ strlen(number),
        /* result = */ &result
    );
    munit_assert_int(ret, ==, 0);
    munit_assert_int(result, ==, 8);

    return MUNIT_OK;
}

MunitTest uint8_t_parse_tests[] = {
    {
        .name = "/parse_valid",
        .test = test_parse_valid
    },
    {0}
};
