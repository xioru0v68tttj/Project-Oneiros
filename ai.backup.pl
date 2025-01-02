#!/data/data/com.termux/files/usr/bin/perl

use Common::Progress;
use Common::Ansi;
use Common::Error;
use File::Copy;

#         ╔═══════════════╷
#         ╷ Project Aoide ┊
#         ╰╼┉┉┉┉┉┉┉┉┉┉┉┉┉╾╵

#   ⊰⚊★   Declare Variables   ★⚊⊱   #
$debug = 0;
($day, $month, $year) = (localtime)[3..5];
$year += 1900;
$month++;
$$_ = sprintf "%02d", $$_ foreach (\$day, \$month);
$dirName = 'Backup';
foreach ('backup', 'backups', 'Backups') { $dirName = $_ if -d "/sdcard/$_" }
$date = "$year-$month-$day";
$dir = "/sdcard/$dirName/$date";

# Define the directories and files you want to back up
my @items_to_backup = (
    "perl",
    "Documents",
    "Images",
    "Alarms",
    "Fonts",
    "Books",
    "somefile.txt",  # Example of a file
    "anotherfile.txt" # Another example of a file
);

# Initialize the backup array
my @backup;

# Check for existence and populate the @backup array
foreach my $item (@items_to_backup) {
    if (-e $item) {
        push @backup, $item;
    } else {
        Warning "Item does not exist: $item";
    }
}

$max = $#backup + 1;
$tasker = "/sdcard/tasker/configs/user";
$max++ if glob("$tasker/*$date.xml");

#   ⊰⚊★      Copy Files      ★⚊⊱   #
`mkdir -p $dir` unless -d $dir;
print "\n";
foreach (0..$#backup) {
    my $item = $backup[$_];
    my $itemFile = $item; # Use the same name for the copied file

    ProgressBar($_, $max, $item);
    if ($debug) { sleep 1 }
    elsif (-d $item) {
        `cd $item && tar -I lz4 -cf - . | pv > $dir/$itemFile.tar.lz4`;
    } else {
        my $cmd = "cp $item $dir/$itemFile";
        print "Executing command: $cmd\n";
        `$cmd`;
        if ($? != 0) {
            Error "Failed to copy $item: $!";
        }
    }
}

#   ⊰⚊★        Tasker        ★⚊⊱   #
if (glob("$tasker/$date.xml")) {
    ProgressBar($#backup + 1, $#backup + 2, 'Tasker');
    Ansi 'hpos';
    copy("$tasker/*$date.xml", "$backup/backup $date.xml");
    print "\n";
} else {
    Ansi "del_line hpos erase_right";
    Warning "Tasker backup not found.";
}

ProgressBar(1, 1, "Backup completed.");
print "\n\n";

#