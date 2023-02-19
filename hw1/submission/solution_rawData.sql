select p, count(*) from Pub group by p;

#       p       |  count  
#———————+————
# article       | 2454629
# book          |   18473
# incollection  |   66325
# inproceedings | 2742757
# mastersthesis |      12
# phdthesis     |   79235
# proceedings   |   46201
# www           | 2667285

with temp as(
select count(distinct p) as num_p
from Pub
),
temp2 as(
select Field.p as p, count(distinct Pub.p) as count
from Field, Pub
where Field.k = Pub.k
group by Field.p
)
select temp2.p
from temp2 
cross join temp
where temp2.count = temp.num_p;

#   p    
# ————
# author
# ee
# note
# title
# year
