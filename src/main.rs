use std::iter::zip;
use std::thread::{self, available_parallelism};

fn main() {
    let vec_len = 10;
    let num_threads = usize::from(available_parallelism().unwrap());
    let a = vec![1; vec_len];
    let b = vec![2; vec_len];
    let mut c = vec![0; vec_len];
    add_vec(
        split_immut_vec(&a, num_threads),
        split_immut_vec(&b, num_threads),
        split_mut_vec(&mut c, num_threads),
    );
    let _: Vec<_> = c.iter().map(|x| println!("{x}")).collect();
}

fn split_immut_vec<T>(v: &Vec<T>, num_slices: usize) -> Vec<Box<&[T]>> {
    let num_slices = std::cmp::min(v.len(), num_slices);
    let slice_len = (v.len() + num_slices - 1) / num_slices;
    let mut res = vec![];
    let mut remaining = &v[..];
    for _ in 0..num_slices - 1 {
        let (head, tail) = remaining.split_at(slice_len);
        remaining = tail;
        res.push(Box::new(head));
    }
    res
}

fn split_mut_vec<T>(v: &mut Vec<T>, num_slices: usize) -> Vec<Box<&mut [T]>> {
    let num_slices = std::cmp::min(v.len(), num_slices);
    let slice_len = (v.len() + num_slices - 1) / num_slices;
    let mut res = vec![];
    let mut remaining = &mut v[..];
    for _ in 0..num_slices - 1 {
        let (head, tail) = remaining.split_at_mut(slice_len);
        remaining = tail;
        res.push(Box::new(head));
    }
    res
}

fn add_vec(a: Vec<Box<&[i32]>>, b: Vec<Box<&[i32]>>, c: Vec<Box<&mut [i32]>>) {
    thread::scope(|s| {
        let _: Vec<_> = zip(zip(a, b), c)
            .map(|((x, y), z)| s.spawn(|| add_vec_slice(x, y, z)))
            .map(|t| t.join())
            .collect();
    })
}

fn add_vec_slice(a: Box<&[i32]>, b: Box<&[i32]>, c: Box<&mut [i32]>) {
    for i in 0..a.len() {
        c[i] = a[i] + b[i];
    }
}
