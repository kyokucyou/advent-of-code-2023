#!/usr/bin/perl

use strict;

my $sum = 0;
while (<>) {
    my @nums = /\d/g;
    $sum += $nums[0] * 10 + $nums[$#nums];
}
print "$sum\n";
