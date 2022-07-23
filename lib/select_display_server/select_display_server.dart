import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_ble/lipl_ble.dart';
import 'package:lipl_bloc/l10n/l10n.dart';

class SelectDisplayServerPage extends StatelessWidget {
  const SelectDisplayServerPage({Key? key}) : super(key: key);

  static Route<void> route() => MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const SelectDisplayServerPage(),
      );

  @override
  Widget build(BuildContext context) => const SelectDisplayServerView();
}

class SelectDisplayServerView extends StatelessWidget {
  const SelectDisplayServerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;

    return BlocBuilder<BleScanCubit, BleScanState>(
      builder: (BuildContext context, BleScanState state) => Scaffold(
        appBar: AppBar(
          title: Text(l10n.selectDisplayServerTitle),
        ),
        body: ListView(
          children: state.devices
              .map(
                // ignore: always_specify_types
                (device) => BlocBuilder<BleConnectionCubit, BleConnectionState>(
                  builder: (BuildContext context,
                      BleConnectionState connectionState) {
                    return ListTile(
                      title: Text(device.name),
                      subtitle: Text(device.id),
                      trailing: state.selectedDevice?.id == device.id
                          ? const CurrentSelectedConnectionButton()
                          : TextButton(
                              onPressed: () async {
                                context.read<BleScanCubit>().select(device);
                                await context.read<BleScanCubit>().stop();

                                Navigator.of(context).pop();
                              },
                              child: const Text('Connect'),
                            ),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class CurrentSelectedConnectionButton extends StatelessWidget {
  const CurrentSelectedConnectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BleConnectionCubit, BleConnectionState>(
        builder: (BuildContext context, BleConnectionState state) => TextButton(
          onPressed: state.isConnected
              ? () async {
                  context.read<BleScanCubit>().select(null);
                }
              : null,
          child: Text(state.isConnected ? 'Disconnect' : 'Connecting'),
        ),
      );
}
