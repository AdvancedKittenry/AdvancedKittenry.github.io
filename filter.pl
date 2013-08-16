#!/usr/bin/perl -p

BEGIN {
    use v5.12;
    use warnings;
    use File::Basename;

    our %tags = (
        exercise => 'success',
        alert    => 'error',
        info     => 'info'
    );

    our %titles = (
        exercise => "Exercise %n",
        alert    => "Watch out!",
        info     => "Hint"
    );

    my %counts;

    our $basedir = dirname($ARGV[0]);
}

for my $tag (keys %tags) {
    my $class = $tags{$tag};
    my $title = $titles{$tag};

    if (/<$tag>/) {
        my $count = ($counts{$tag} ||= 1)++;

        $title =~ s/%n/$count/;

        my $replacement = qq[<section class="alert alert-$class"><h3>$title</h3>];

        s#<$tag>#$replacement#;
    }

    s#</$tag>#\n</section>#;
}

#Parses include files while leaving title metadata lines beginning with % out
s{<include +src="([^"]*)" */>} {"\n" . `$0 $basedir/$1` =~ s/^(%[^\n]*)*//rg . "\n";}e;
#Removes comment tags
s#<comment>.*?</comment>##;
