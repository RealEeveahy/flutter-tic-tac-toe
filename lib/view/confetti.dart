import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/engine.dart';
import 'package:particles_flutter/interactions.dart';
import 'package:particles_flutter/physics.dart';
import 'package:particles_flutter/shapes.dart';

class ConfettiController extends StatefulWidget{
  ConfettiController({super.key});
  late _ConfetState myState;

  @override
  // ignore: no_logic_in_create_state
  State createState() => myState = _ConfetState();
}

class _ConfetState extends State<ConfettiController> {
  bool active = false;

  set switchState(bool newState)
  {
    setState((() { active = newState; }));
  }
  bool get state => active;

  @override
  Widget build(BuildContext context) {
    if(!active)
      return SizedBox();
    else
      return ConfettiMachine();
  }
}

class ConfettiMachine extends StatelessWidget{
  const ConfettiMachine({super.key});

  @override
  Widget build(BuildContext context)
  {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Particles(
            particles: createParticles(),
            height: constraints.maxHeight, 
            width: constraints.maxWidth,
            boundType: BoundType.None,
            particleEmitter: Emitter(
              startPosition: Offset(constraints.maxWidth/2, constraints.maxHeight),
              startPositionRadius: 20,
              clusterSize: 2,
              delay: Duration(microseconds:1),
            ),
            particlePhysics: ParticlePhysics(),
            interaction: ParticleInteraction(
              onTapAnimation: false,
              enableHover: false,
            ),
          );
        }
    );
  }

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 100; i++) {
      particles.add(RoundRectangularParticle(
        color: Color.fromRGBO(rng.nextInt(200) + 55, rng.nextInt(200) + 55, rng.nextInt(200) + 55, 1.0),
        width: 30,
        height: 10,
        rotationSpeed: ((25 * rng.nextDouble()) + 10) * randomSign(),
        cornerRadius: 20,
        velocity: Offset(rng.nextDouble() * 80 * randomSign(), 400 * -1 + (50 * rng.nextDouble())),
      ));
    }
    return particles;
  }
    double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1 : -1;
  }
}