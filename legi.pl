#!/usr/bin/perl

# Program to filter Wikipedia XML dumps to "clean" text consisting only of lowercase
# letters (a-z, converted from A-Z), and spaces (never consecutive).  
# All other characters are converted to spaces.  Only text which normally appears 
# in the web browser is displayed.  Tables are removed.  Image captions are 
# preserved.  Links are converted to normal text.  Digits are spelled out.

# Written by Matt Mahoney, June 10, 2006.  This program is released to the public domain.



$/=">";                     # input record separator
while (<>) {
  s/\r|\n//g; # remove cariage

  if (/<CONTENU>/) {$text=1;}  # remove all but between <text> ... </text>
  if (/<NUM>/) {$num=1;}  

  if ($num) {
    if (/<\/NUM>/) {$num=0;}
    s/<NUM>/__LABEL_NAME___/g;

    $_="$_ ";
    s/<.*>//;
    chop;
    print $_;
  }

  if ($text) {
    # Remove any text not normally visible
    if (/<\/CONTENU>/) {$text=0;}
    # remove all but between <text> ... </text>
    else {
      # convert to lowercase letters and spaces, spell digits
        $_=" $_ ";
        s/0/ zero /g;
        s/1/ one /g;
        s/2/ two /g;
        s/3/ three /g;
        s/4/ four /g;
        s/5/ five /g;
        s/6/ six /g;
        s/7/ seven /g;
        tr/A-Z/a-z/;
#      tr/a-z|__LABEL_NANE__/ /cs;  
    }

    s/<.*>//;               # remove xml tags
    chop;
    print $_;
  }
}
