# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# 35941 is broken
%w(2003475 1320438 34411 36145 2003477 36127 36132 36133 2003476 36134 34488 1633562 2003476).each do |relation_id|
  osm_data = `curl http://www.openstreetmap.org/api/0.6/relation/#{relation_id}/full`
  File.open("#{relation_id}.osm",'w'){|f| f.write osm_data}
end
