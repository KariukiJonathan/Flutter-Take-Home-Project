import 'dart:convert';

class new_APi {
  final array = 
[
  {
    "id": "35",
    "is_filled": false,
    "is_locked": true,
    "sku": {
      "id": "267",
      "name": "6 KG",
      "capacity": 6,
      "created_by": {
      "id": "458",
      "name": "Alice Bugatti"
      }
    }
  }
];

  
Map<String, Object> toJson(){
  return{
    "created_by": {
      "name": "someone",
        "capacities": {
          "xkgs": [
            {
            "id": "123",
            "name": "x kgs"
            }
          ]
        }
      }
    };
}
}
