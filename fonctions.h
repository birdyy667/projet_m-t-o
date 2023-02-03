#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct data {
  int col1;
  int col2;
};

int compare(const void *a, const void *b);
void sort_csv(const char *file_name) ;