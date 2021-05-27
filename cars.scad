cars_db=[
//["car_name", [height, width, topOffset, bottomOffset, hookTopDepth, hookBottomDepth, hookType]]
["VWGolf",[70,60,70,50,10,20,"in"]],
["SkodaOctaviaIII",[70,60,70,50,10,20,"out"]],
];

function carindex(name, cars) = search([name],cars, num_returns_per_match=1)[0];

function getcar(name, cars = cars_db) = cars[carindex(name, cars)][1];

echo(getcar("VWGolf"));
