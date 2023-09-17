class Product{
final String title,description,category;
final double price,rate;
final String images;
final int count,id;


Product({
  required this.title,
  required this.description,
  required this.category,required this.price,required this.rate,
  required this.images,required this.count,required this.id});

factory Product.fromJson(Map<String, dynamic> json) => Product(
  id: json["id"],
  title: json["title"],
  price: json["price"],
  description: json["description"],
  category: json["category"],
  rate: json["rate"],
  images: json["image"],
  count: json["count"],
);

Map<String, dynamic> toJson() {
  return {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "rate": rate,
    "image": images, // Store only the first image for simplicity
    "count": count,
  };
}

}

List<Product> products=[
  Product(
    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    category: "men's clothing",
    price: 190.95,
    rate: 3.9,
    images: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmIGvZj6DvHD78FQ8ppcBFO3O9UJActAvuXQ&usqp=CAU",
    count: 120,
    id: 1,
  ),

  Product(
    title: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
    description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
    category: "jewelery",
    price: 695.0,
    rate: 4.9,
    images: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmIGvZj6DvHD78FQ8ppcBFO3O9UJActAvuXQ&usqp=CAU",
    count: 400,
    id: 2,
  ),






];