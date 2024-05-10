#include <stdlib.h>

int main(int argc, char *argv[])
{
    int* array = malloc(100*sizeof(int));
    free(array);
    return array[1];
}
