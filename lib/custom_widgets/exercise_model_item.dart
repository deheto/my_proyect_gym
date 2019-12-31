import '../providers/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseModelItem extends StatelessWidget {

  final ExerciseModel exercise;

  ExerciseModelItem(this.exercise);

  @override
  Widget build(BuildContext context) {
     return ClipRRect(
  
      child: GridTile(
        child: Image.network(
          exercise.imageURL,
          fit: BoxFit.cover
        ),
        footer: Text(
          exercise.name
        ),
      ),
     );

  }
}

//  return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: GridTile(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pushNamed(
//               ProductDetailScreen.routeName,
//               arguments: product.id,
//             );
//           },
//           child: Image.network(
//             product.imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//         footer: GridTileBar(
//           backgroundColor: Colors.black87,
//           leading: Consumer<Product>(
//             builder: (ctx, product, _) => IconButton(
//                   icon: Icon(
//                     product.isFavorite ? Icons.favorite : Icons.favorite_border,
//                   ),
//                   color: Theme.of(context).accentColor,
//                   onPressed: () {
//                     product.toggleFavoriteStatus(
//                       authData.token,
//                       authData.userId,
//                     );
//                   },
//                 ),
//           ),
//           title: Text(
//             product.title,
//             textAlign: TextAlign.center,
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.shopping_cart,
//             ),
//             onPressed: () {
//               cart.addItem(product.id, product.price, product.title);
//               Scaffold.of(context).hideCurrentSnackBar();
//               Scaffold.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Added item to cart!',
//                   ),
//                   duration: Duration(seconds: 2),
//                   action: SnackBarAction(
//                     label: 'UNDO',
//                     onPressed: () {
//                       cart.removeSingleItem(product.id);
//                     },
//                   ),
//                 ),
//               );
//             },
//             color: Theme.of(context).accentColor,
//           ),
//         ),
//       ),
//     );