
class Operationen{

  static double? calculateInputString(String input){

    List<String> teile = input.split(' ');

    if(teile.length != 3){
      return null;
    }

    double num1 = double.parse(teile[0]);
    double num2 = double.parse(teile[2]);

    switch (teile[1]) {
      case "+":
        return num1 + num2;
        
      case "-":
        return num1 - num2;

      case "X":
        return num1 * num2;

      case "/":
        return num1 / num2;

      default:
        return null;
    }

    } 



    static bool isOperator(String zeichen){
      if(zeichen == "X" || zeichen == "/" || zeichen == "+" || zeichen == "-"){
        return true;
      }
      else{
        return false;
      }
    }

    static bool isDigit(String zeichen){
      double? x = double.tryParse(zeichen);

      if(x == null) return false;

      return true;
    }
}