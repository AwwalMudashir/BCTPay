import 'package:bctpay/globals/index.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  var cardListBloc = ApisBloc(ApisBlocInitialState());
  int limit = 10;
  int page = 1;

  @override
  void initState() {
    super.initState();
    cardListBloc.add(GetCardsListEvent(limit: limit, page: page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cardListBloc,
      builder: (context, state) {
        if (state is GetCardsListState) {
          var cards = state.value.data ?? [];
          if (cards.isEmpty) {
            return SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: appLocalizations(context).card),
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cards.length,
                  itemBuilder: (context, index) => ListAnimation(
                    index: index,
                    child: CardListItem(
                      card: cards[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Loader();
      },
    );
  }
}
