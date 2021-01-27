class Claculator {
  double result;
  sumCalculator(dynamic x1, String _operator, dynamic x2) {
    switch (_operator) {
      case '+':
        result = x1 + x2.toDouble();
        return result;
      case '−':
        result = x1 - x2.toDouble();
        return result;
        break;
      case '×':
        result = x1 * x2.toDouble();
        return result;
      case '÷':
        result = x1 / x2.toDouble();
        return result;
        break;
      default:
    }
  }
}
