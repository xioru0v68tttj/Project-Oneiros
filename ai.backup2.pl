#!/data/data/com.termux/files/usr/bin/perl

use Common::Progress;
use Common::Ansi;
use Common::Error;
use File::Copy;

#         ╔═══════════════╷
#         ╷ Project Aoide ┊
#         ╰╼┉┉┉┉┉┉┉┉┉┉┉┉┉╾╵

#   ⊰⚊★   Declare Variables   ★⚊⊱   #
my $debug = 0x01;  # 0x01 = Error handling, 0x02 = Other debugging options
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
    "/sdcard/perl",
    "/sdcard/Documents",
    "/sdcard/Images",
    "/sdcard/Alarms",
    "/sdcard/Fonts",
    "/sdcard/Books",
    "/sdcard/somefile.txt",  # Example of a file
    "/sdcard/anotherfile.txt" # Another example of a file
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

# Check for Tasker files
my $tasker = "/sdcard/tasker/configs/user";
my @tasker_files = glob("$tasker/*$date.xml");  # Adjust this pattern as needed

$max = $#backup + 1 + @tasker_files;

#   ⊰⚊★      Copy Files      ★⚊⊱   #
`mkdir -p $dir`;
if ($? != 0 && ($debug & 0x01)) {
    Error "Failed to create directory $dir: $!";
}

print "\n";
foreach (0..$#backup) {
    my $item = $backup[$_];
    my $itemFile = $item; # Use the same name for the copied file

    ProgressBar($_, $max, $item);
    if ($debug & 0x02) { sleep 1 }  # Optional debug pause

    if (-d $item) {
        my $cmd = "rsync -a --progress $item/ $dir/$itemFile/";
        print "Executing command: $cmd\n" if ($debug & 0x02);
        `$cmd`;
        if ($? != 0 && ($debug & 0x01)) {
            Error "Failed to back up directory $item: $!";
        }
    } else {
        my $cmd = "rsync -a --progress $item $dir/$itemFile";
        print "Executing command: $cmd\n" if ($debug & 0x02);
        `$cmd`;
        if ($? != 0 && ($debug & 0x01)) {
            Error "Failed to copy file $item: $!";
        }
    }
}

#   ⊰⚊★        Tasker        ★⚊⊱   #
foreach my $tasker_file (@tasker_files) {
    ProgressBar($#backup + 1, $#backup + 2, 'Tasker');
    Ansi 'hpos';
    my $cmd = "cp $tasker_file $dir/";
    print "Executing command: $cmd\n" if ($debug & 0x02);
    `$cmd`;
    if ($? != 0 && ($debug & 0x01)) {
        Error "Failed to copy Tasker file $tasker_file: $!";
    }
}

if (!@tasker_files) {
    Ansi "del_line hpos erase_right";
    Warning "No Tasker files found for the date: $date.";
}

ProgressBar(1, 1, "Backup completed.");
print "\n\n";
