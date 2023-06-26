use std::iter::zip;
use std::thread;

fn main() {
    let vec_len = 10;
    let a = vec![1; vec_len];
    let b = vec![2; vec_len];
    let mut c = vec![0; vec_len];
    let (al, ar) = a.split_at(vec_len / 2);
    let (bl, br) = b.split_at(vec_len / 2);
    let (cl, cr) = c.split_at_mut(vec_len / 2);
    let al = Box::new(al);
    let ar = Box::new(ar);
    let bl = Box::new(bl);
    let br = Box::new(br);
    let cl = Box::new(cl);
    let cr = Box::new(cr);
    add_vec(vec![al, ar], vec![bl, br], vec![cl, cr]);
    let _: Vec<_> = c.iter().map(|x| println!("{x}")).collect();
}

fn add_vec(a: Vec<Box<&[i32]>>, b: Vec<Box<&[i32]>>, c: Vec<Box<&mut [i32]>>) {
    let _: Vec<_> = zip(zip(a, b), c)
        .map(|((x, y), z)| thread::spawn(|| add_vec_slice(x, y, z)))
        .map(|t| t.join())
        .collect();
}

fn add_vec_slice(a: Box<&[i32]>, b: Box<&[i32]>, c: Box<&mut [i32]>) {
    for i in 0..a.len() {
        c[i] = a[i] + b[i];
    }
}
