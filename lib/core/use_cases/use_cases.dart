abstract class useCase<T, P> {
  Future<T> execute({required P params});
}

abstract class noParamUseCases<T> {
  Future<T> noParamCall();
}