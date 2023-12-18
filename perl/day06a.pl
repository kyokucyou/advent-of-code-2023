#!/usr/bin/perl

use strict;

my @races;
while (<>) {
    my $i = 0;
    push $races[$i++]->@*, int $1 while /(\d+)/g;
}
my @beaten;
for my $race (@races) {
    my ($time, $record) = @$race;
    my @times = map { $_ * ($time - $_) } 0 .. $time;
    my $beaten = grep { $_ > $record } @times;
    push @beaten, $beaten;
}
my $prod = 1;
$prod *= $_ for @beaten;
print "$prod\n";
