class EvalResult {
  final String varieties;
  final double cost;
  final double product;
  final double price;
  final double profit;

  EvalResult({
    this.varieties,
    this.cost,
    this.product,
    this.price,
    this.profit,
  });
}

List<EvalResult> evalresult = [
  EvalResult(
    varieties: 'กข-1',
    cost: 1000,
    product: 100,
    price: 1200,
    profit: 11000,
  ),
  EvalResult(
    varieties: 'กข-2',
    cost: 1200,
    product: 100,
    price: 1200,
    profit: 10800,
  ),
  EvalResult(
    varieties: 'กข-3',
    cost: 2000,
    product: 100,
    price: 1200,
    profit: 10000,
  ),
  EvalResult(
    varieties: 'กข-4',
    cost: 5000,
    product: 100,
    price: 1200,
    profit: 7000,
  ),
  EvalResult(
    varieties: 'กข-5',
    cost: 800,
    product: 50,
    price: 1200,
    profit: 5400,
  ),
];
