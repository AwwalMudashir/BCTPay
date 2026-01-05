import 'package:bctpay/globals/index.dart';

class ContactListItem extends StatefulWidget {
  final Contact contact;
  final void Function()? onTap;

  const ContactListItem({super.key, required this.contact, this.onTap});

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  // Uint8List? photoOrThumbnail;

  // getThumb() async {
  //   photoOrThumbnail = await FastContacts.getContactImage(widget.contact.id);
  // }

  @override
  void initState() {
    super.initState();
    // getThumb();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.all(5),
        color: tileColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 50,
                child: Card(
                    color: tileColor,
                    elevation: 5,
                    child: FutureBuilder(
                        future: FastContacts.getContactImage(widget.contact.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Uint8List? photoOrThumbnail = snapshot.data;
                            return photoOrThumbnail != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      photoOrThumbnail,
                                      height: 50,
                                      width: 50,
                                      cacheHeight: cacheHeight,
                                      cacheWidth: cacheWidth,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  );
                          }
                          return const Icon(
                            Icons.person,
                            color: Colors.grey,
                          );
                        })),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.contact.displayName,
                      style:
                          textTheme.titleSmall?.copyWith(color: Colors.black),
                    ),
                    if (widget.contact.phones.isNotEmpty)
                      Text(
                        widget.contact.phones.first.number,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall
                            ?.copyWith(color: themeGreyColor),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
