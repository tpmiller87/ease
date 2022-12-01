# ease
Small, simple collection of bash one-liners made into a script to extract hashes and users from a CME NTDS dump.

Usage:

Syntax: ./ease.sh [-h|n|c|l|a] <filename>
options:
  

  -h     Print help!

  -n     Extract only the NTLM hash.

  -c     Extract the NTLM and users in hash:user format for correlation.

  -l     Extract only usernames.

  -a     Do all options and output each to a new file.
