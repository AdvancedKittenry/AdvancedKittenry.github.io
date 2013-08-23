#!/usr/bin/perl 

undef $/;

my $path = $ARGV[0];

$_ = <STDIN>;

s#<li>(<a href="(\.\.\/)*$path">)#<li class="selected">\1#;

print;
