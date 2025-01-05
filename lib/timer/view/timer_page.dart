import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_flutter/constants/Modes.dart';
import 'package:learn_flutter/providers/pulse_timer.dart';
import 'package:learn_flutter/ticker.dart';
import 'package:learn_flutter/timer/bloc/timer_bloc.dart';
import 'package:learn_flutter/widgets.dart/modes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            width: 400,
            height: 330,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary, // Shadow color
                  offset: Offset(1, 0.5), // Shadow position (X, Y)
                  blurRadius: 2, // How much the shadow should spread
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Modes(
                        timer.mode[modes.ShortBreak.name],
                        timer.activeMode == modes.ShortBreak.name,
                        timer.handleMode,
                      ),
                      Modes(
                        timer.mode[modes.Focus.name],
                        timer.activeMode == modes.Focus.name,
                        timer.handleMode,
                      ),
                      Modes(
                        timer.mode[modes.LongBreak.name],
                        timer.activeMode == modes.LongBreak.name,
                        timer.handleMode,
                      ),
                    ],
                  ),
                ),
                TimerText(),
                Actions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: GoogleFonts.varelaRound(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        height: 1.0,
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  ElevatedButton(
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      // Text color
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Text(
                      'START',
                      style: GoogleFonts.dongle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              TimerRunInProgress() => [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPaused()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Icon(
                      Icons.pause,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Icon(
                      Icons.replay,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              TimerRunPause() => [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResumed()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Icon(
                      Icons.play_arrow,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Icon(
                      Icons.replay,
                      size: 30,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              TimerRunComplete() => [
                  ElevatedButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerReset()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      // Text color
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                      // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Adjust border radius here
                      ),
                      elevation: 2,
                    ), // Button shadow),
                    child: Text(
                      'RESTART',
                      style: GoogleFonts.dongle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
            }
          ],
        );
      },
    );
  }
}
