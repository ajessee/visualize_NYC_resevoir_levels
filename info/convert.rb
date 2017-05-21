OldMax = 1445
OldMin = 1314 
NewMax = 39666
NewMin = 1680  
OldValue = 1410

OldRange = OldMax - OldMin
puts OldRange
NewRange = NewMax - NewMin  
puts NewRange

NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin

puts NewValue