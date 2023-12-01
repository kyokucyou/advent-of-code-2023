#!/usr/bin/perl

use strict;

my @words = qw/one two three four five six seven eight nine/;
my %nums;
@nums{@words} = 1 .. 9;
my $re = '(?=([1-9]|' . join('|', @words) . '))';
my $sum = 0;
while (<>) {
    my @matches;
    push @matches, $nums{$1} // $1 while /$re/g;
    $sum += $matches[0] * 10 + $matches[$#matches];
}
print "$sum\n";
