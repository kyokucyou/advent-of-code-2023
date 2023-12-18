#!/usr/bin/perl

use strict;

my ($seq, %nodes);
$/ = '';
while (<>) {
    if ($. == 1) {
        s/[^LR]+//g;
        $seq = $_;
    } else {
        while (/(\w{3})\W+(\w{3})\W+(\w{3})/g) {
            $nodes{$1} = [$2, $3];
        }
    }
}
my $node = 'AAA';
my $steps = 0;
do {
    $node = $nodes{$node}[substr(
        $seq,
        $steps % length($seq),
        1
    ) eq 'L' ? 0 : 1];
    ++$steps;
} while $node ne 'ZZZ';
print "$steps\n";
