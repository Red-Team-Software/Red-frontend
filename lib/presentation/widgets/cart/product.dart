import 'package:GoDeli/features/cart/domain/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        openThreshold: 0.3,
        
        children: [
          SlidableAction(
            onPressed: (context) {
              // onRemove(); // Llama a la función para eliminar el producto
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ]
      ),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagen del producto (puede ser un icono o una imagen de red)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image, size: 40, color: Colors.grey[500]),
            ),
            const SizedBox(width: 8), // Espacio entre la imagen y el texto
            // Información del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8), // Espacio entre la imagen y el texto
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
      
              children: [
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width:16), // Espacio entre el precio y el control de cantidad
                // Control de cantidad
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  height: 35,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
                        onPressed: () {
                          // Lógica para disminuir la cantidad
                        },
                      ),
                      Text(
                        '${product.quantity}', // Aquí muestra la cantidad actual
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
      
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.red, size: 20),
                        onPressed: () {
                          // Lógica para aumentar la cantidad
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
            // Precio
            ,
          ],
        ),
      ),
    );
  }
}

//* Por si quiero usar dissmisable
// Dismissible(
//       key: Key(product.id.toString()), // Una clave única para cada producto
//       direction: DismissDirection.endToStart,
//       background: Container(
//         color: Colors.red,
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Icon(Icons.delete, color: Colors.white),
//       ),
//       onDismissed: (direction) {
//         // onRemove(); // Llama a la función para eliminar el producto
//       },
//       child: Container(