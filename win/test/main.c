#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

int main () {
    uv_loop_init(uv_default_loop());

    printf("Now quitting.\n");

    uv_run(uv_default_loop(), UV_RUN_DEFAULT);

    uv_loop_close(uv_default_loop());
    return 0;
}
