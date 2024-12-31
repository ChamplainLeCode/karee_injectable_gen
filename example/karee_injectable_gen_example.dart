import 'package:build/build.dart';
import 'package:karee_inject/karee_inject.dart';
import 'package:karee_injectable_gen/karee_injectable_gen.dart' as gen;

@Service
class InjectableService {
  int testService() {
    return 3;
  }
}

void main() {
  gen.serviceBuilder(BuilderOptions.forRoot);
}
