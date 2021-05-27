phones_db=[
//["phone_name", width, height, thickness]
["A2LiteCover",[76,80,13]],
["A2Lite",[72,78,9]],
];

function phoneindex(name, phones) = search([name],phones, num_returns_per_match=1)[0];

function getphone(name, phones = phones_db) = phones[phoneindex(name, phones)][1];

//echo(getphone("A2Lite"));
