use strict;
use warnings;
use v5.10;
use List::Util qw(sum);

my $score = 0;
my @scoreboard = ();
while(<STDIN>){
    chomp;
    $_ =~ s/(A|X)/R/g;
    $_ =~ s/(B|Y)/P/g;
    $_ =~ s/(C|Z)/S/g;

    my @input = split(' ', $_);
    my $result = rockPaperScissors_cmp($input[1], $input[0]);

    if ($input[1] eq 'R') {$score += 1;}
    elsif ($input[1] eq 'P') {$score += 2;}
    elsif ($input[1] eq 'S') {$score += 3;}

    if ($result == 1) {$score += 6;}
    elsif ($result ==0) {$score += 3;}
    
    push @scoreboard, $score;
    $score = 0;
}

say sum @scoreboard;




sub rockPaperScissors_cmp {
    my ($a, $b, @others) = @_;

    if ($a =~ m/^[rR]/) {
        if ($b =~ m/^[rR]/) {return 0;}
        elsif ($b =~ m/^[pP]/) {return -1;}
        elsif ($b =~ m/^[sS]/) {return 1;}
    } elsif ($a =~ m/^[pP]/) {
        if ($b =~ m/^[rR]/) {return 1;}
        elsif ($b =~ m/^[pP]/) {return 0;}
        elsif ($b =~ m/^[sS]/) {return -1;}
    } elsif ($a =~ m/^[sS]/){
        if ($b =~ m/^[rR]/) {return -1;}
        elsif ($b =~ m/^[pP]/) {return 1;}
        elsif ($b =~ m/^[sS]/) {return 0;}
    }
}