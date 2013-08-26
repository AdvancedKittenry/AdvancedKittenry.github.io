#!/usr/bin/perl -p

BEGIN {
    use v5.12;
    use warnings;
    use File::Basename;

    our %tags = (
        exercise => 'success',
        alert    => 'error',
        info     => 'info',
        arvosanamaksimi => "heading small",
        vaikeustaso => "heading small"
    );

    our %titles = (
        exercise => "Exercise %n",
        alert    => "Pidä mielessä!",
        info     => "Vinkki",
        arvosanamaksimi => "Arvosanamaksimi: ",
        vaikeustaso => "Vaikeustaso: "
    );

    undef $/;

    my %counts;
    our $basedir = dirname($ARGV[0]);

    my $curdir = $basedir =~ s#^src/?##r;
    if (length($curdir) > 0) {
      $curdir = $curdir . "/";
    }
    my $rootdir = $curdir =~ s#[^/]+#..#rg;

    our %dirs = (
      curdir => $curdir,
      rootdir => $rootdir,
      imgdir => $rootdir."images/",
      myimgdir => $rootdir."images/".$curdir
    );
}

for my $tag (keys %tags) {
    my $class = $tags{$tag};
    my $title = $titles{$tag};

    if (/<$tag>/) {
        my $count = ($counts{$tag} ||= 1)++;

        $title =~ s/%n/$count/;

        my $replacement = qq[<section class="alert alert-$class"><h3>$title</h3>];

        s#<$tag>#$replacement#g;
    }

    s#</$tag>#\n</section>#g;
}

for my $dir (keys %dirs) {
    my $dirval = $dirs{$dir};

    s#{{$dir}}#$dirval#g;
}

#Parses include files while leaving title metadata lines beginning with % out
s{<include +src="([^"]*)" */>} {"\n" . `$0 $basedir/$1` =~ s/^(%[^\n]*)*//rg . "\n";}eg;
#Removes comment tags
s#<comment>.*?</comment>##sg;
s#<!-- addHeaderNavigation -->#<script>addSectionLinks = true; </script>#sg;
