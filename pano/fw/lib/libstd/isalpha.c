#ifdef CONFIG_USE_LOCAL_STRING_H
#include "_string.h"
#else
#include <string.h>
#endif

//-----------------------------------------------------------------
// isupper:
//-----------------------------------------------------------------
int isupper(int c)
{
   if(c >= 'A' && c <= 'Z')
      return 1;
   else
      return 0;
}
//-----------------------------------------------------------------
// isalpha:
//-----------------------------------------------------------------
int isalpha(int c)
{
   if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
      return 1;
   else
      return 0;
}
//-----------------------------------------------------------------
// isdigit:
//-----------------------------------------------------------------
int isdigit(int c)
{
   if(c >= '0' && c <= '9')
      return 1;
   else
      return 0;
}
//-----------------------------------------------------------------
// isspace:
//-----------------------------------------------------------------
int isspace(int c)
{
   if (c == ' ' || c == '\f' || c == '\n' || c == '\r' || c == '\t' || c == '\v')
      return 1;
   else
      return 0;
}
//-----------------------------------------------------------------
// isalnum:
//-----------------------------------------------------------------
int isalnum(int c)
{
   if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9'))
      return 1;
   else
      return 0;
}


//-----------------------------------------------------------------
// isxdigit:
//-----------------------------------------------------------------
int isxdigit(int c)
{
   if ((c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F') || (c >= '0' && c <= '9'))
      return 1;
   else
      return 0;
}
