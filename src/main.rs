use num_traits::Num;
use std::iter::zip;
use std::ops::AddAssign;
use std::thread::{self, available_parallelism};

fn main() {
    // parallel vector add
    let vec_len = 10;
    let num_threads = usize::from(available_parallelism().unwrap());
    let a = vec![1; vec_len];
    let b = vec![2; vec_len];
    let mut c = vec![0; vec_len];
    add_vec(&a, &b, &mut c, num_threads);
    add_vec_unsafe(
        ConstPtrWrapper(&a[0] as *const i32),
        ConstPtrWrapper(&b[0] as *const i32),
        MutPtrWrapper(&mut c[0] as *mut i32),
        vec_len,
        num_threads,
    );
    let _: Vec<_> = c.iter().map(|x: &i32| println!("{x}")).collect();

    println!();

    // parallel matrix multiplication
    let m = 10;
    let n = 10;
    let k = 10;
    let a = vec![1; m * k];
    let b = vec![1; k * n];
    let mut c = vec![10; m * n];
    matmul(&a, &b, &mut c, m, n, k, num_threads);
    matmul_unsafe(
        ConstPtrWrapper(&a[0] as *const i32),
        ConstPtrWrapper(&b[0] as *const i32),
        MutPtrWrapper(&mut c[0] as *mut i32),
        m,
        n,
        k,
        num_threads,
    );
    for x in 0..m {
        for y in 0..n {
            print!("{} ", c[x * n + y]);
        }
        println!();
    }
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
    res.push(Box::new(remaining));
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
    res.push(Box::new(remaining));
    res
}

fn add_vec<T: Num + Send + Sync + Copy>(
    a: &Vec<T>,
    b: &Vec<T>,
    c: &mut Vec<T>,
    num_threads: usize,
) {
    let a = split_immut_vec(a, num_threads);
    let b = split_immut_vec(b, num_threads);
    let c = split_mut_vec(c, num_threads);
    thread::scope(|s| {
        let _: Vec<_> = zip(zip(a, b), c)
            .map(|((x, y), z)| s.spawn(|| add_vec_slice(x, y, z)))
            .map(|t| t.join())
            .collect();
    })
}

fn add_vec_slice<T: Num + Copy>(a: Box<&[T]>, b: Box<&[T]>, c: Box<&mut [T]>) {
    for i in 0..a.len() {
        c[i] = a[i] + b[i];
    }
}

#[derive(Clone, Copy)]
struct ConstPtrWrapper<T>(*const T);

unsafe impl<T> Send for ConstPtrWrapper<T> {}
unsafe impl<T> Sync for ConstPtrWrapper<T> {}

#[derive(Clone, Copy)]
struct MutPtrWrapper<T>(*mut T);

unsafe impl<T> Send for MutPtrWrapper<T> {}
unsafe impl<T> Sync for MutPtrWrapper<T> {}

fn add_vec_unsafe<T: Num + Copy>(
    a: ConstPtrWrapper<T>,
    b: ConstPtrWrapper<T>,
    c: MutPtrWrapper<T>,
    n: usize,
    num_slices: usize,
) {
    let num_slices = std::cmp::min(n, num_slices);
    let slice_len = (n + num_slices - 1) / num_slices;

    thread::scope(|s| {
        let _: Vec<_> = (0..num_slices)
            .into_iter()
            .map(|i| {
                s.spawn(move || {
                    for j in (slice_len * i)..(std::cmp::min(slice_len * (i + 1), n)) {
                        let k = j as isize;
                        let a = a;
                        let b = b;
                        let c = c;
                        unsafe {
                            *(c.0).offset(k) = *(a.0).offset(k) + *(b.0).offset(k);
                        }
                    }
                })
            })
            .map(|h| h.join())
            .collect();
    })
}

fn split_immut_matrix<T>(
    v: &Vec<T>,
    height: usize,
    width: usize,
    num_slices: usize,
) -> Vec<Box<&[T]>> {
    let num_slices = std::cmp::min(height, num_slices);
    let slice_len = ((height + num_slices - 1) / num_slices) * width;
    let mut res = vec![];
    let mut remaining = &v[..];
    for _ in 0..num_slices - 1 {
        let (head, tail) = remaining.split_at(slice_len);
        remaining = tail;
        res.push(Box::new(head));
    }
    res.push(Box::new(remaining));
    res
}

fn split_mut_matrix<T>(
    v: &mut Vec<T>,
    height: usize,
    width: usize,
    num_slices: usize,
) -> Vec<Box<&mut [T]>> {
    let num_slices = std::cmp::min(height, num_slices);
    let slice_len = ((height + num_slices - 1) / num_slices) * width;
    let mut res = vec![];
    let mut remaining = &mut v[..];
    for _ in 0..num_slices - 1 {
        let (head, tail) = remaining.split_at_mut(slice_len);
        remaining = tail;
        res.push(Box::new(head));
    }
    res.push(Box::new(remaining));
    res
}

// C(m, n) = A(m, k) * B(k, n)
fn matmul<T: Num + AddAssign + Send + Sync + Copy>(
    a: &Vec<T>,
    b: &Vec<T>,
    c: &mut Vec<T>,
    m: usize,
    n: usize,
    k: usize,
    num_threads: usize,
) {
    let a = split_immut_matrix(a, m, k, num_threads);
    let mut a_slice_lens = vec![];
    a.iter().for_each(|aa| a_slice_lens.push(aa.len() / k));
    let c = split_mut_matrix(c, m, n, num_threads);
    thread::scope(|s| {
        let _: Vec<_> = zip(zip(a, a_slice_lens), c)
            .map(|((aa, aa_len), cc)| s.spawn(move || matmul_slice(aa, b, cc, aa_len, n, k)))
            .map(|t| t.join())
            .collect();
    })
}

// C(m, n) = A(m, k) * B(k, n)
fn matmul_slice<T: Num + AddAssign + Copy>(
    a: Box<&[T]>,
    b: &[T],
    c: Box<&mut [T]>,
    m: usize,
    n: usize,
    k: usize,
) {
    c.iter_mut().for_each(|item| *item = T::zero());
    for x in 0..m {
        for z in 0..k {
            for y in 0..n {
                // c[x][y] += a[x][z] * b[z][y]
                c[x * n + y] += a[x * k + z] * b[z * n + y];
            }
        }
    }
}

// C(m, n) = A(m, k) * B(k, n)
fn matmul_unsafe<T: Num + AddAssign + Copy>(
    a: ConstPtrWrapper<T>,
    b: ConstPtrWrapper<T>,
    c: MutPtrWrapper<T>,
    m: usize,
    n: usize,
    k: usize,
    num_threads: usize,
) {
    for i in 0..(k * n) {
        unsafe {
            *(c.0).offset(i as isize) = T::zero();
        }
    }
    let num_slices = std::cmp::min(m, num_threads);
    let slice_len = (n + num_slices - 1) / num_slices;
    thread::scope(|s| {
        let _: Vec<_> = (0..num_slices)
            .into_iter()
            .map(|thread_id| {
                s.spawn(move || {
                    for x in
                        (thread_id * slice_len)..(std::cmp::min((thread_id + 1) * slice_len, m))
                    {
                        for z in 0..k {
                            for y in 0..n {
                                let a = a;
                                let b = b;
                                let c = c;

                                // c[x][y] += a[x][z] * b[z][y]
                                // c[x * n + y] += a[x * k + z] * b[z * n + y];
                                unsafe {
                                    *(c.0).offset((x * n + y) as isize) += *(a.0)
                                        .offset((x * k + z) as isize)
                                        * *(b.0).offset((z * n + y) as isize);
                                }
                            }
                        }
                    }
                })
            })
            .map(|h| h.join())
            .collect();
    });
}
