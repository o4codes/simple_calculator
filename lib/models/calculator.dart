class Calculator{
  double firstNumber;
  double secondNumber;
  double result;
  String operation;

  Calculator(this.operation, this.result);

  double add(){
    return result = this.firstNumber + this.secondNumber;
  }
  double subtract(){
    return result = this.firstNumber - this.secondNumber;
  }
  double divide(){
    return result = this.firstNumber / this.secondNumber;
  }
  double multiply(){
    return result = this.firstNumber * this.secondNumber;
  }

  double percent(){
    return result = this.firstNumber/100;
  }
}


