
use std::ops::{Index, IndexMut};
use std::ptr::{NonNull, null_mut};
use std::{vec,mem::transmute};
use std::alloc::{alloc, dealloc, Layout};

//#[allow(unused_tem)]
pub type PoolId<T> = NonNull<T>;

/// An large array of element, where each element have an fixed/stable pointer
pub struct Block<T>
{
    /// Allocated once, then never re-allocated
    data :  *mut T,
    len  :  usize,
}

impl<T> Drop for Block<T>
{
    fn drop(&mut self) 
    {
        unsafe
        {
            dealloc(self.data as *mut u8, Layout::array::<T>(self.len).unwrap());
        }
        self.data = null_mut::<T>();
        self.len  = 0;
    }
}

impl<T> Block<T>
{
    fn new(count  : usize) -> Self
    {
        let layout = Layout::array::<T>(count).unwrap();
        unsafe
        {
            let ptr = alloc(layout) as *mut T;
            Block { data: ptr, len: count }
        }
    }
}

struct AvailablePoolRange<T>
{
    ptr : NonNull<T>,
    qte : usize,
}

pub struct Pool<T, const COUNT: usize = 2048>
{
    blocks : Vec<Block<T>>,
    available : Vec<AvailablePoolRange<T>>,
    pub nb_alloc_active : u64,
    can_only_free : bool,
}

impl<T, const COUNT: usize>  Default for Pool<T, COUNT> 
{
    fn default() -> Self 
    {
        Pool {
            blocks: vec![],
            available: Vec::with_capacity(COUNT),
            nb_alloc_active : 0,
            can_only_free : false,
        }
    }
}

/// Todo : alloc_array(&mut self, qte : usize)
/// Todo : free_array(&mut self, val: *mut T, qte : usize)
impl<T, const COUNT: usize> Pool<T, COUNT> 
{
    pub fn new() -> Self { Self::default() }



    /// alloc
    pub fn alloc(&mut self, val: T) -> PoolId<T>
    {
        assert_eq!(self.can_only_free, false);

        self.nb_alloc_active+=1;
        debug_assert!(COUNT >= 1);
        unsafe
        {
            if self.available.is_empty()
            {
                let c = COUNT;
                self.blocks.push(Block::new(c));
                self.available.push(AvailablePoolRange { ptr: NonNull::new(self.blocks.last_mut().unwrap_unchecked().data).unwrap_unchecked(), qte: c});
            }
            let last = self.available.last_mut().unwrap_unchecked();
            last.qte  -= 1;
            let r = ((last.ptr).as_ptr()).add(last.qte);
    
            if last.qte == 0
            {
                self.available.pop();
            }

            std::ptr::write(r, val); // avoid the drop of the old value
            //NonNull::new(r).unwrap_unchecked()
            transmute(r)
        }
    }

    /// free
    pub fn remove_from_pool(&mut self, val: PoolId<T>) -> T
    {
        debug_assert_ne!(self.nb_alloc_active, 0);
        self.nb_alloc_active -= 1;

        unsafe
        {

            let ptr =  std::mem::transmute::<PoolId<T>, *mut T>(val);
            if !self.can_only_free
            {
                self.available.push(AvailablePoolRange{ptr : NonNull::new_unchecked(ptr), qte : 1});
            }
            ptr.read() //.drop_in_place();
        }
    }

    /// The other pool is left empty
    pub fn absorb(&mut self, mut absorbed : Self)
    {
        //assert_ne!(self as *const Self, absorbed as *const Self);
        self.blocks.append(&mut absorbed.blocks);
        self.available.append(&mut absorbed.available);
    }

    pub fn no_more_allocation(&mut self)
    {
        assert_eq!(self.can_only_free, false);
        self.can_only_free = true;
    }

    #[inline(always)]
    pub fn get_id(&self, val : &T) -> PoolId<T>
    {
        unsafe{transmute(val)}
    }
}

impl<T,const COUNT: usize> Drop for Pool<T, COUNT>
{
    fn drop(&mut self) 
    {
        if self.nb_alloc_active != 0
        {
            println!("pool have {} malloc undropped !", self.nb_alloc_active);
        }
        //drop(self.blocks); // assume those are dropped by rust
        //drop(self.available);
    }
}

impl<T, const COUNT : usize> Index<PoolId<T>> for Pool<T, COUNT>
{
    type Output = T;
    #[inline(always)]
    fn index(&self, index: PoolId<T>) -> &Self::Output {
        unsafe{transmute(index)}
    }
}
impl<T, const COUNT : usize> IndexMut<PoolId<T>> for Pool<T, COUNT>
{
    #[inline(always)]
    fn index_mut(&mut self, index: PoolId<T>) -> &mut Self::Output {
        unsafe{transmute(index)}
    }
}