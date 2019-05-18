#ifdef DEBUG
#warning Building in DEBUG mode.
#endif
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

%%{
    machine uint8_t_parser;

    action copy {
        *result *= 10;
        *result += *p - '0';
    }

    action error {
        #ifdef DEBUG
            fprintf(stderr,
                "uint8_t_parse failed here: "
                "p='%.16s', *p='%02x', state='%d', "
                "buf='%.*s', buf_len='%ld', index='%d'\n",
                p, *p, fcurs, buf_len, buf, p - buf, buf_len
            );
        #endif
    }

    uint8_t =
    ( '0'
    | '1' [0-9]{0,2}
    | '2' 
        ( [0-4][0-9]?
        | '5' [0-5]?
        | [6-9]
        )?
    | [3-9][0-9]?
    );

    main := uint8_t $copy $err(error);

    write data;
}%%

int uint8_t_parse (
    char const * const buf,
    const int buf_len,
    uint8_t * result
)
{      
    int cs;
    *result = 0;

    %% write init;
    
    const char * p = buf;
    const char * pe = buf + buf_len;
    const char * eof = 0;

    %% write exec;

    if (cs == %%{ write error; }%%) {
        return -1;
    }
    if (cs < %%{ write first_final; }%%) {
        return -1;
    }

    return 0;
}
