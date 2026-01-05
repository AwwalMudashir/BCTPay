import 'package:bctpay/globals/index.dart';

class SlotView extends StatelessWidget {
  final SlotInfo slot;
  final SelectionBloc quantityBloc;
  final String? ticketCounterViewStatus;

  const SlotView({
    super.key,
    required this.slot,
    required this.quantityBloc,
    this.ticketCounterViewStatus,
  });

  @override
  Widget build(BuildContext context) {
    quantityBloc.add(SelectIntEvent(slot.quantity));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Slot",
          style: textTheme(context)
              .titleMedium
              ?.copyWith(color: themeLogoColorOrange),
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedLanguage == 'en'
                ? slot.slotTypeEn ?? ""
                : slot.slotTypeGn ?? ""),
            5.width,
            Text(formatCurrency(slot.perSlotPrice ?? "0")),
          ],
        ),
        if (ticketCounterViewStatus?.isNotEmpty ?? false
            ? ticketCounterViewStatus?.toLowerCase() == "true"
            : false) ...[
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appLocalizations(context).availableSlots),
              Text(
                "${slot.remainingSlot}/${slot.totalSlot}",
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(color: themeLogoColorOrange),
              ),
            ],
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appLocalizations(context).quantity),
            BlocConsumer(
                bloc: quantityBloc,
                listener: (context, state) {
                  if (state is SelectIntState) {
                    slot.quantity = state.value;
                  }
                },
                builder: (context, state) {
                  if (state is SelectIntState) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: themeLogoColorOrange,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                if (state.value > 1) {
                                  quantityBloc
                                      .add(SelectIntEvent(state.value - 1));
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 20,
                              )),
                          Text("${state.value}"),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                if (double.parse(slot.maxLimit ?? "0") >
                                    state.value) {
                                  quantityBloc
                                      .add(SelectIntEvent(state.value + 1));
                                } else {
                                  showToast(appLocalizations(context)
                                      .maxLimitIs(slot.maxLimit ?? "0"));
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                size: 20,
                              )),
                        ],
                      ),
                    );
                  }
                  return Loader();
                }),
          ],
        ),
      ],
    );
  }

  double getBookedSlots(SlotInfo slot) =>
      double.parse(slot.totalSlot ?? '0') -
      double.parse(slot.remainingSlot ?? '0');
}
