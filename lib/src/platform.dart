abstract class PlatformProvider {
  Future<TResult> compute<TArg, TResult>(
      TResult Function(TArg) heavyWork, TArg arg);
}
