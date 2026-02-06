use std::env;


const BAZ: &str = env!("BAZ");

fn main() {

    if env::var("BAZ").unwrap_or_default() != "lorem:ipsum" {
        panic!("BAZ is not defined!");
    }

    for (key, value) in env::vars() {
        println!("{}: {}", key, value);
    }

}
