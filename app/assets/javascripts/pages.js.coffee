# source: http://zreference.com/raphael-animation-along-a-path
Raphael.fn.addGuides = ->
  @ca.guide = (g) ->
    guide: g

  @ca.along = (percent) ->
    g = @attr("guide")
    len = g.getTotalLength()
    point = g.getPointAtLength(percent * len)
    t = transform: "t" + point.x + " " + point.y
    t

$ ->
  paper = Raphael document.getElementById('canvas_container'), 800, 600
  paper.addGuides()
  path1 = paper.path "M20,20 L300,40 L300,300 L100,70 l500,500"
  path2 = paper.path("M 100 100 Q 200 500 300 100")
 
  #length = path.getTotalLength()

  mover1 = paper.circle(0, 0, 10).attr
    stroke: "none"
    fill: "#dd1111"

  mover2 = paper.circle(0, 0, 10).attr
    stroke: "none"
    fill: "#11dd11"

  $(document).click ->
    console.log 'click'
    mover1.attr(
      guide : path1
      along : 0
    ).animate
      along : 1
    , 10000, "ease-out"
    mover2.attr(
      guide : path2
      along : 0
    ).animate
      along : 1
    , 6000, "ease-out"
