use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

fn read_input() -> String {
    // Create a path to the desired file
    let path = Path::new("input.txt");
    let display = path.display();

    // Open the path in read-only mode, returns `io::Result<File>`
    let mut file = match File::open(&path) {
        Err(why) => panic!("couldn't open {}: {}", display, why),
        Ok(file) => file,
    };

    // Read the file contents into a string, returns `io::Result<usize>`
    let mut s = String::new();
    match file.read_to_string(&mut s) {
        Err(why) => panic!("couldn't read {}: {}", display, why),
        Ok(_) => print!("{} contains:\n{}", display, s),
    }

    return s;
}


fn main() {
    let input = read_input();
    let depths = input.lines();

    let mut cpt = 0;
    let mut last = i32::MAX;

    for sonar in depths {
        println!("{}", sonar);
        let val: i32 = sonar.parse().unwrap();
        if  val > last {
            cpt += 1;
        }
        last = val;
    }

    println!("{}", cpt);
}
