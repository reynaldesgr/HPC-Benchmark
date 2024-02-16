use std::f64::consts::PI;

const DAYS_PER_YEAR: f64 = 365.24;
const SOLAR_MASS: f64 = 4.0 * PI.powi(2);

struct Vec3 {
    x: f64,
    y: f64,
    z: f64,
}

impl Vec3 {
    fn new(x: f64, y: f64, z: f64) -> Self {
        Vec3 { x, y, z }
    }

    fn zero() -> Self {
        Vec3::new(0.0, 0.0, 0.0)
    }

    fn minus(&self, other: &Vec3) -> Vec3 {
        Vec3 {
            x: self.x - other.x,
            y: self.y - other.y,
            z: self.z - other.z,
        }
    }

    fn multiply_by_scalar(&self, scalar: f64) -> Vec3 {
        Vec3 {
            x: self.x * scalar,
            y: self.y * scalar,
            z: self.z * scalar,
        }
    }

    fn magnitude(&self) -> f64 {
        (self.x * self.x + self.y * self.y + self.z * self.z).sqrt()
    }

    fn add(&mut self, other: Vec3) {
        self.x += other.x;
        self.y += other.y;
        self.z += other.z;
    }
}

struct Body {
    position: Vec3,
    velocity: Vec3,
    mass: f64,
}

impl Body {
    fn new(position: Vec3, velocity: Vec3, mass: f64) -> Self {
        Body {
            position,
            velocity: velocity.multiply_by_scalar(DAYS_PER_YEAR),
            mass: mass * SOLAR_MASS,
        }
    }
}

fn advance(bodies: &mut [Body], dt: f64) {
    let pairs = (0..bodies.len()).flat_map(move |i| (i + 1..bodies.len()).map(move |j| (i, j)));

    for (i, j) in pairs {
        let delta = bodies[i].position.minus(&bodies[j].position);
        let distance = delta.magnitude();
        let mag = dt / (distance * distance * distance);

        let delta_i = delta.multiply_by_scalar(bodies[j].mass * mag);
        bodies[i].velocity.add(delta_i);

        let delta_j = delta.multiply_by_scalar(bodies[i].mass * mag);
        bodies[j].velocity.add(delta_j.multiply_by_scalar(-1.0));
    }

    for body in bodies.iter_mut() {
        body.position.add(body.velocity.multiply_by_scalar(dt));
    }
}

fn energy(bodies: &[Body]) -> f64 {
    let mut e = 0.0;

    for i in 0..bodies.len() {
        e += 0.5
            * bodies[i].mass
            * (bodies[i].velocity.x.powi(2) + bodies[i].velocity.y.powi(2) + bodies[i].velocity.z.powi(2));

        for j in i + 1..bodies.len() {
            let delta = bodies[i].position.minus(&bodies[j].position);
            let distance = delta.magnitude();
            e -= bodies[i].mass * bodies[j].mass / distance;
        }
    }

    e
}

fn main() {
    let mut bodies = vec![
        // Sun
        Body::new(Vec3::zero(), Vec3::zero(), 1.0),
        // Jupiter
        Body::new(
            Vec3::new(4.84143144246472090, -1.16032004402742839, -0.103622044471123109),
            Vec3::new(0.00166007664274403694, 0.00769901118419740425, -0.0000690460016922064603),
            0.000954791938424326609,
        ),
        // Saturn
        Body::new(
            Vec3::new(8.34336671824457987, 4.12479856412430479, -0.403523417114321381),
            Vec3::new(-0.00276742510726862411, 0.00499852801234917238, 0.0000230417297573763920),
            0.000285885980666130812,
        ),
        // Uranus
        Body::new(
            Vec3::new(12.8943695621391310, -15.1111514016986312, -0.223307578892655734),
            Vec3::new(0.00296460137564761618, 0.00237847173959480950, -0.0000296589568540237556),
            0.0000436624404335875075,
        ),
        // Neptune
        Body::new(
            Vec3::new(15.3796971148509165, -25.9193146099879641, 0.179258772950371181),
            Vec3::new(0.00268067772490389322, 0.00162824170038242295, -0.0000951592254519715876),
            0.0000515138902046611451,
        ),
    ];

    let mut total_energy_initial = energy(&bodies);
    println!("Initial total energy: {}", total_energy_initial);

    let dt = 0.01;
    for _ in 0..10000 {
        advance(&mut bodies, dt);
    }

    let total_energy_final = energy(&bodies);
    println!("Final total energy: {}", total_energy_final);
}