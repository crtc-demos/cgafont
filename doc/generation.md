How fonts are generated
=======================

The basic idea is that a language defines each of the possible forms of 
each glyph. The language describes general shapes in terms of points and 
the lines between them. Constraints are then defined around the points, 
giving the generator room to vary the font. These constraints, where 
possible, are shared between all the glyphs of the font, in order to 
give it a consistent style.

Defining points and lines
-------------------------

Our canvas is a square, and each point is described by two coordinates, 
x and y:

      x=0       x=1
    y=0 +-------+
        |       |
        |       |
        |       |
        |       |
    y=1 +-------+

Let's say we want to draw a '1'. I like there to be a vertical line with 
a little upstroke. So we've got three points now.

      x=0       x=1
    y=0 +---b---+
        |  /|   |
        | a |   |
        |   |   |
        |   |   |
    y=1 +---c---+

We can write these as follows:

    point a  x=0.25 y=0.4
    point b  x=0.5  y=0
    point c  x=0.5  y=1
    line  ab from=a to=b 
    line  bc from=b to=c

Points always have one-character names.

### Point constraints

This doesn't give the generator much freedom to change the font, so we 
vary the constraints on these objects.

   perturb a uniform limit=0.1
   perturb a gaussian sd=0.2

This will allow the generator to change the position of the point, but 
only within limits. A variation will impose a lower fitness on the 
glyph, depending on the kind of limit imposed.

### Constraints and punishment

The first line specifies a hard limit with the deviation possibly 
imposing a punishment based on the distance between the defined point 
and the perturbed one. The second line specifies the standard deviation 
of a Gaussian distribution, a softer limit. The generator could use this 
to allow it to freely perturb locally to the point but to be punished 
more severly for more outlying points. For example, the fitness could be 
related to the value of a 2-dimensional Gaussian function around the 
point concerned.

This approach is readily applicable to the other objects that define a 
font.

### Line constraints

Lines are defined by two points.

   thicken [ab bc] uniform range=0.05..0.2
   thicken [ab bc] gaussian mean=0.12 sd=0.07

This will allow the generator to use a thickness of the given range, but 
it must be applied to all the line segments listed between the square 
brackets.

### Corner constraints

Corners are defined by three points, with the corner being on the middle 
point.

   bevel abc uniform range=0..0.2
   bevel abc gaussian mean=0.1 sd=0.05

This will allow the generator to draw a bevel effect on the corner 
defined. The bevel may be of a size between those listed.
