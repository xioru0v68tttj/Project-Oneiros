use strict;
use warnings;
use JSON;
use Data::Dumper;

# Step 1: Define emotional states
my %emotional_states = (
    'fear' => 'A response to perceived threats',
    'anger' => 'A reaction to perceived injustice',
    'joy' => 'A feeling of great pleasure and happiness',
    'sadness' => 'A state of feeling sorrowful',
    # Add more emotions as needed
);

# Step 2: Input Processing
sub preprocess_input {
    my ($input) = @_;
    # Basic preprocessing: convert to lowercase and remove punctuation
    $input = lc($input);
    $input =~ s/[^\w\s]//g;
    return $input;
}

# Step 3: Emotion Recognition
sub recognize_emotion {
    my ($input) = @_;
    my $response;

    foreach my $emotion (keys %emotional_states) {
        if ($input =~ /\b$emotion\b/i) {
            $response = "Detected emotion: $emotion - " . $emotional_states{$emotion};
            last;
        }
    }

    return $response || "No specific emotion detected.";
}

# Step 4: Response Generation
sub generate_response {
    my ($emotion) = @_;
    if ($emotion) {
        return "Thank you for sharing your feelings of $emotion.";
    } else {
        return "I'm here to listen. Please tell me more.";
    }
}

# Step 5: Learning Mechanism (Placeholder)
sub learn_from_interaction {
    my ($input, $emotion) = @_;
    # Placeholder for learning mechanism
    # This could involve saving data to a database for future analysis
}

# Main execution
my $user_input = "I feel a lot of fear about the upcoming project.";
my $processed_input = preprocess_input($user_input);
my $detected_emotion = recognize_emotion($processed_input);
my $response = generate_response($detected_emotion);

# Learning from interaction
learn_from_interaction($user_input, $detected_emotion);

print "$response\n";

# #2::

# Step 1: Define emotional states across species
emotional_states = {
    'mammals': {
        'fear': 'Response to threats',
        'joy': 'Playful behavior',
        # Add more emotions as needed
    },
    'birds': {
        'aggression': 'Defensive posturing',
        'contentment': 'Singing and preening',
        # Add more emotions as needed
    },
    # Add more species categories
}

# Step 2: Input Processing
function preprocess_input(data):
    # Extract relevant features from input data
    return processed_data

# Step 3: Behavior Recognition
function recognize_behavior(processed_data):
    for species in emotional_states:
        if behavior_matches(species, processed_data):
            return "Detected behavior: " + species
    return "No specific behavior detected."

# Step 4: Response Generation
function generate_response(behavior):
    if behavior:
        return "Observed behavior indicates emotional state: " + behavior
    else:
        return "No significant behavior observed."

# Step 5: Learning Mechanism
function learn_from_interaction(data, behavior):
    # Store data for future analysis and learning
    store_data(data, behavior)

# Main execution
input_data = capture_input()  # Capture data from sensors or cameras
processed_data = preprocess_input(input_data)
detected_behavior = recognize_behavior(processed_data)
response = generate_response(detected_behavior)

# Learning from interaction
learn_from_interaction(input_data, detected_behavior)

print(response)

#3:
use strict;
use warnings;
use JSON;

# Initialize dynamic emotional states
my %dynamic_emotional_states = (
    'satisfaction' => {
        'count' => 0,
        'description' => 'The AI feels satisfied when tasks are completed successfully.'
    },
    'frustration' => {
        'count' => 0,
        'description' => 'The AI feels frustrated when it encounters errors or obstacles.'
    },
    'curiosity' => {
        'count' => 0,
        'description' => 'The AI feels curious when it encounters new data or challenges.'
    },
    'confusion' => {
        'count' => 0,
        'description' => 'The AI feels confused when it cannot process input or understand a request.'
    }
);

#4:
use strict;
use warnings;
use JSON;

# Initialize dynamic emotional states
my %dynamic_emotional_states = ();

# Function to add or update an emotional state
sub update_emotional_state {
    my ($state, $description) = @_;
    $dynamic_emotional_states{$state} = {
        'description' => $description,
        'count' => 0
    };
}

# Function to preprocess input data
sub preprocess_input {
    my ($data) = @_;
    return lc($data);  # Convert to lowercase for easier matching
}

# Function to learn from interaction
sub learn_from_interaction {
    my ($emotion, $feedback) = @_;
    
    # Update the count for the corresponding emotional state
    if (exists $dynamic_emotional_states{$emotion}) {
        $dynamic_emotional_states{$emotion}{'count'} += 1;
    } else {
        # If the emotion doesn't exist, create a new one
        update_emotional_state($emotion, "Learned from interaction.");
    }
    
    # Log the interaction for future analysis
    open my $log, '>>', 'learning_log.txt' or die "Could not open learning log: $!";
    print $log "Emotion: $emotion | Feedback: $feedback\n";
    close $log;
}

# Function to generate a response based on the current emotional state
sub generate_response {
    my ($emotion) = @_;
    
    if (exists $dynamic_emotional_states{$emotion}) {
        return "I am currently feeling: " . $dynamic_emotional_states{$emotion}{'description'};
    }
    
    return "I am currently in a neutral state.";
}

# Function to collect feedback from users
sub collect_feedback {
    my ($emotion, $user_feedback) = @_;
    learn_from_interaction($emotion, $user_feedback);
}

# Main execution
my $input_data = "I feel great!";  # Example input
my $processed_data = preprocess_input($input_data);

# Simulate recognizing an emotion based on input (for demonstration)
my $detected_emotion = "satisfaction";  # This would be determined by your logic
collect_feedback($detected_emotion, "Positive feedback received.");

# Generate a response based on the detected emotion
my $response = generate_response($detected_emotion);
print "$response\n";

#5:
#!/usr/bin/perl
use strict;
use warnings;

# Function to generate C code for a simple AI with emotional awareness
sub generate_c_code {
    my ($emotion) = @_;
    
    my $c_code = <<'END_C_CODE';
#include <stdio.h>
#include <string.h>

#define MAX_EMOTIONS 10

typedef struct {
    char name[50];
    char description[100];
    int count;
} Emotion;

Emotion emotions[MAX_EMOTIONS];
int emotion_count = 0;

void add_emotion(const char* name, const char* description) {
    if (emotion_count < MAX_EMOTIONS) {
        strcpy(emotions[emotion_count].name, name);
        strcpy(emotions[emotion_count].description, description);
        emotions[emotion_count].count = 1;  // Initialize count
        emotion_count++;
    }
}

void learn_emotion(const char* name) {
    for (int i = 0; i < emotion_count; i++) {
        if (strcmp(emotions[i].name, name) == 0) {
            emotions[i].count++;
            return;
        }
    }
    // If not found, add a new emotion
    add_emotion(name, "Learned from interaction.");
}

void print_emotions() {
    printf("Current Emotions:\\n");
    for (int i = 0; i < emotion_count; i++) {
        printf("Emotion: %s, Description: %s, Count: %d\\n", emotions[i].name, emotions[i].description, emotions[i].count);
    }
}

int main() {
    // Initialize some emotions
    add_emotion("satisfaction", "The AI feels satisfied when tasks are completed successfully.");
    add_emotion("frustration", "The AI feels frustrated when it encounters errors or obstacles.");
    
    // Simulate learning an emotion based on input
    learn_emotion("satisfaction");  // Simulate learning satisfaction
    learn_emotion("frustration");   // Simulate learning frustration
    learn_emotion("satisfaction");   // Simulate learning satisfaction again

    // Print current emotions
    print_emotions();
    
    return 0;
}
END_C_CODE

    return $c_code;
}

# Main execution
my $emotion = "satisfaction";  # Example input for generating C code
my $c_code = generate_c_code($emotion);

# Write the C code to a file
my $filename = 'emotional_ai.c';
open my $fh, '>', $filename or die "Could not open file '$filename' $!";
print $fh $c_code;
close $fh;

# Compile the C code
system("gcc $filename -o emotional_ai");

# Execute the compiled program
my $output = `./emotional_ai`;
print $output;

#6:
sub generate_c_code {
    my ($emotion, $user_input) = @_;
    
    my $c_code = <<'END_C_CODE';
#include <stdio.h>
#include <string.h>

#define MAX_EMOTIONS 10

typedef struct {
    char name[50];
    char description[100];
    int count;
} Emotion;

Emotion emotions[MAX_EMOTIONS];
int emotion_count = 0;

void add_emotion(const char* name, const char* description) {
    if (emotion_count < MAX_EMOTIONS) {
        strcpy(emotions[emotion_count].name, name);
        strcpy(emotions[emotion_count].description, description);
        emotions[emotion_count].count = 1;  // Initialize count
        emotion_count++;
    }
}

void learn_emotion(const char* name) {
    for (int i = 0; i < emotion_count; i++) {
        if (strcmp(emotions[i].name, name) == 0) {
            emotions[i].count++;
            return;
        }
    }
    // If not found, add a new emotion
    add_emotion(name, "Learned from interaction.");
}

void respond_to_input(const char* input) {
    if (strstr(input, "happy") != NULL) {
        learn_emotion("satisfaction");
        printf("I'm glad to hear you're happy!\\n");
    } else if (strstr(input, "sad") != NULL) {
        learn_emotion("sadness");
        printf("I'm sorry to hear that.\\n");
    } else {
        printf("I don't understand that emotion.\\n");
    }
}

void print_emotions() {
    printf("Current Emotions:\\n");
    for (int i = 0; i < emotion_count; i++) {
        printf("Emotion: %s, Description: %s, Count: %d\\n", emotions[i].name, emotions[i].description, emotions[i].count);
    }
}

int main() {
    // Initialize some emotions
    add_emotion("satisfaction", "The AI feels satisfied when tasks are completed successfully.");
    add_emotion("frustration", "The AI feels frustrated when it encounters errors or obstacles.");
    
    // Simulate user input
    char user_input[100];
    printf("Enter your emotion: ");
    fgets(user_input, sizeof(user_input), stdin);
    user_input[strcspn(user_input, "\n")] = 0;  // Remove newline character

    respond_to_input(user_input);  // Respond based on user input
    print_em