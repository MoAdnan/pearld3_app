extension ResponseStatus<T> on String {
  int toErrorCode(){
    switch(this){
      case 'registerdevice':{
        return 0;
      }
      default:{return 0;}

    }

  }
}