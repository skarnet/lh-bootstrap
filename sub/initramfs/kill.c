 /* GPLv2 license. */

#include <skalibs/nonposix.h>
#include <signal.h>
#include <skalibs/types.h>
#include <skalibs/sgetopt.h>
#include <skalibs/strerr2.h>
#include <skalibs/sig.h>
#include <skalibs/nsig.h>

#define USAGE "kill [ -s SIGNAME ] pids..."
#define dieusage() strerr_dieusage(100, USAGE)

int main (int argc, char const *const *argv)
{
  int sig = 15 ;
  PROG = "kill" ;
  {
    subgetopt_t l = SUBGETOPT_ZERO ;
    for (;;)
    {
      int opt = subgetopt_r(argc, argv, "s:", &l) ;
      if (opt == -1) break ;
      switch (opt)
      {
        case 's':
        {
          sig = sig_number(l.arg) ;
          if (!sig)
          {
            unsigned int u ;
            if (!uint0_scan(l.arg, &u)) dieusage() ;
            if (u > SKALIBS_NSIG) dieusage() ;
            sig = u ;
          }
          break ;
        }
        default : dieusage() ;
      }
    }
    argc -= l.ind ; argv += l.ind ;
  }
  if (!argc) dieusage() ;

  {
    pid_t pids[argc] ;
    for (unsigned int i = 0 ; i < argc ; i++)
      if (!pid0_scan(argv[i], pids + i)) dieusage() ;
    for (unsigned int i = 0 ; i < argc ; i++)
      if (kill(pids[i], sig) < 0)
        strerr_warnwu2sys("kill pid ", argv[i]) ;
  }
  return 0 ;
}

