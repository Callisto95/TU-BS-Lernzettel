#set text(font: "Inter", size: 1.25em, lang: "de")
// #show math.equation: set text(font: "Fira Math")
#show link: set text(fill: blue)

= Quadrille
#[
    #import "@local/quadrille:0.3.2": *

    #let graph = graph.with(scale: 1cm)

    See https://typst.app/universe/package/quadrille.

    - `graph` is everything
    - at least one of `x` or `y` is needed
    - `step` sets the step of the graph axis
        - if there's a `x-` and `y-` variant of the parameter, it's for the axis
    - `scale` sets the size of the graph
    - a point is `(X, Y, LABEL)`
    - `segment.stroke` is just Typst's #link("https://typst.app/docs/reference/visualize/stroke/", `stroke`)
    - `points` can be connected directly, no need for a `points` and a `segment`
    - `points` label position (`pos`) can only be set per `points`, not per point
    - `points` style can be set via `mark`
    - a slight overdraw can be achieved with `clip: false`
    - `axes` shifts the axes - either cross at `(0,0)` or bottom and left
    - a simple `name` adds the name next to the element, an explicit `label: name` adds it to the legend instead
    - `area(Y)` fills the entire `x` area up to the given `y`
        - `area` with a `domain` allows the colouring of a specific area
    - `annotate` to place text anywhere
    - grid subdivision via `minor`
    - `style`: see https://github.com/ngelkind/quadrille#style
    - `arc` has three parameters
        - `WHERE` - where the arc will be drawn; modify with `radius`, angle can be shown with `value: auto`
        - `FROM` and `TO`: a raycast from `WHERE`, in between which the angle is drawn
        - ! this needs a local installation, `0.3.2` is not published
    - `parametric`: a function $X in (0, 2 pi), X mapsto (x,y)$
        - domain can be set

    #graph(
        x: (-3, 3),
        y: (-1, 6),
        scale: 1cm,
        fn(x => x * x, label: $x^2$),
        fn(x => x * x - 1, $x^2 - 1$, domain: (1, 2)),
        points((1, 1, $A$), (-1, 1, "B"), label: "some points"),
        segment((1, 1), (-1, 1)),
        segment((1, 2), (-1, 2), extend: true, stroke: (dash: "dashed")),
        area(1, 2, domain: (1, 2)),
        area(x => x * x, x => x * x - 1, domain: (1,2), fill: red.lighten(75%)),
        annotate((2, 1), "weird area", pos: bottom + right),
        arc((0, 0), (-2, 2), (2, 0), $alpha$, value: auto),
        parametric(x => (x, 3), $beta$, domain: (-3, 0)),
        legend: top + left,
    )
]

= simple-plot
#[
    #import "@preview/simple-plot:1.1.0": *

    See https://typst.app/universe/package/simple-plot

    - `xtick`, `ytick`: at which points should ticks on the axis be made?
    - `data.connect` also needs `data.stroke`
        - use `line-plot` for connected points

    #plot(
        xmin: -3,
        xmax: 3,
        ymin: -1,
        ymax: 6,
        ylabel: $f(x)$,
        show-grid: true,
        minor-grid-step: 1,
        (fn: x => x * x, label: $x^2$),
        fill-area(x => x * x, domain: (-2, 2), color: blue.lighten(75%)),
        area-between(x => 5, x => x * x, color: red.lighten(75%), domain: (-2, 2)),
        data(((-2, 2), (0, 3)), mark: "diamond", label: "data", connect: true, stroke: red),
        hline(5),
        line-plot(((-2, 5), (0, 1), (2, 0))),
    )

    #plot(
        xmin: 0,
        xmax: 3,
        ymin: 0,
        ymax: 5,
        riemann-sum(
            x => calc.pow(x, 2),
            domain: (0.0, 3.0),
            n: 6,
            method: "left",
            color: blue.lighten(75%),
            show-points: true, // dots at evaluation points
            show-dx: true, // Δx bracket under one rectangle
            show-xi: true, // x₀, x₁, …, x₆ labels along axis
        ),
        (fn: x => calc.pow(x, 2), stroke: blue + 1.5pt),
    )
]
