require 'matrix'

PI = 3.14159265358979323
SOLAR_MASS = 4 * PI * PI
DAYS_PER_YEAR = 365.24

BODIES = {
  'sun' => [Vector[0.0, 0.0, 0.0], Vector[0.0, 0.0, 0.0], SOLAR_MASS],

  'jupiter' => [Vector[4.84143144246472090e+00,
                       -1.16032004402742839e+00,
                       -1.03622044471123109e-01],
                Vector[1.66007664274403694e-03 * DAYS_PER_YEAR,
                       7.69901118419740425e-03 * DAYS_PER_YEAR,
                       -6.90460016972063023e-05 * DAYS_PER_YEAR],
                9.54791938424326609e-04 * SOLAR_MASS],

  'saturn' => [Vector[8.34336671824457987e+00,
                      4.12479856412430479e+00,
                      -4.03523417114321381e-01],
               Vector[-2.76742510726862411e-03 * DAYS_PER_YEAR,
                      4.99852801234917238e-03 * DAYS_PER_YEAR,
                      2.30417297573763929e-05 * DAYS_PER_YEAR],
               2.85885980666130812e-04 * SOLAR_MASS],

  'uranus' => [Vector[1.28943695621391310e+01,
                      -1.51111514016986312e+01,
                      -2.23307578892655734e-01],
               Vector[2.96460137564761618e-03 * DAYS_PER_YEAR,
                      2.37847173959480950e-03 * DAYS_PER_YEAR,
                      -2.96589568540237556e-05 * DAYS_PER_YEAR],
               4.36624404335156298e-05 * SOLAR_MASS],

  'neptune' => [Vector[1.53796971148509165e+01,
                       -2.59193146099879641e+01,
                       1.79258772950371181e-01],
                Vector[2.68067772490389322e-03 * DAYS_PER_YEAR,
                       1.62824170038242295e-03 * DAYS_PER_YEAR,
                       -9.51592254519715870e-05 * DAYS_PER_YEAR],
                5.15138902046611451e-05 * SOLAR_MASS]
}

SYSTEM = BODIES.values
PAIRS = SYSTEM.combination(2).to_a

def advance(dt, n, bodies=SYSTEM, pairs=PAIRS)
  n.times do
    pairs.each do |((r1, v1, m1), (r2, v2, m2))|
      d = r1 - r2
      distance = d.magnitude
      mag = dt / (distance * distance * distance)
      v1 -= d * (m2 * mag)
      v2 += d * (m1 * mag)
    end
    bodies.each do |(r, v, m)|
      r += v * dt
    end
  end
end

def report_energy(bodies=SYSTEM, pairs=PAIRS, e=0.0)
  pairs.each do |((r1, v1, m1), (r2, v2, m2))|
    d = r1 - r2
    distance = d.magnitude
    e -= (m1 * m2) / distance
  end
  bodies.each do |(r, v, m)|
    e += m * v.magnitude**2 / 2
  end
  puts "%.9f" % e
end

def offset_momentum(ref, bodies=SYSTEM)
  p = Vector[0.0, 0.0, 0.0]
  bodies.each do |(r, v, m)|
    p -= v * m
  end
  ref_body = BODIES[ref]
  ref_body[1] += p / ref_body[2]
end

def main(n, ref='sun')
  offset_momentum(ref)
  report_energy
  advance(0.01, n)
  report_energy
end

if __FILE__ == $0
  n = ARGV[0].to_i
  main(n)
end