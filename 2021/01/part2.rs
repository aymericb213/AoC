use std::str::FromStr;

fn read_all<T: FromStr>(file_name: &str) -> Vec<Result<T, <T as FromStr>::Err>> {
    std::fs::read_to_string(file_name)
        .expect("file not found!")
        .lines()
        .map(|x| x.parse())
        .collect()
}

fn main() {
    let input = read_all::<i32>("input.txt");

    let mut cpt = 0;
    let mut last = i32::MAX;

    for i in 2..input.len() {
        let val: i32 = input[i].as_ref().unwrap() + input[i-1].as_ref().unwrap() + input[i-2].as_ref().unwrap();
        if  val > last {
            cpt += 1;
        }
        last = val;
    }

    println!("{}", cpt);
}
