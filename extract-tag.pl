#!/usr/bin/env perl

my $tag = $ARGV[0];
my $file = $ARGV[1];

my $_ = do {
  open(my $fh, "<", $file)
    or die("Can't open \"$name\": $!\n");
  local $/;
  <$fh>
};

s#.*?([^\S\n]*<$tag.*</$tag>).*#\1#s;

#Find all the indenting space before the tag
/^(\s*)/;
s#^$1##mg;

print;
