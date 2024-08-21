class Product{
  String? name;
  
  String? imgUrl;
 
  double? quantity;
  double? price;
  
  Product(this.name,this.price,this.imgUrl,this.quantity);
    Map<String, dynamic> toMap() {
    return {

      'name': name,
      'price': price!*quantity!,
      
      'imgUrl': imgUrl,
      'quantity': quantity,
    };
  }


 
 
}