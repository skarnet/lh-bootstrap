s/choose compile load tryshsgr\.c hasshsgr\.h1 hasshsgr\.h2 chkshsgr /choose compile load tryshsgr.c hasshsgr.h1 hasshsgr.h2 /
s/ar cr /$(TRIPLE)-ar cr /
s/ranlib /$(TRIPLE)-ranlib /
s%\./chkshsgr ||%true ||%
s%\./choose clr tryshsgr hasshsgr\.h1 hasshsgr\.h2 > hasshsgr\.h%cat hasshsgr.h1 > hasshsgr.h%
