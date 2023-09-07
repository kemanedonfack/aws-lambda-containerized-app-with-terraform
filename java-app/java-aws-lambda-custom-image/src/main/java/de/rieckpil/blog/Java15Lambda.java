package de.rieckpil.blog;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class Java15Lambda implements RequestHandler<Void, String> {

  @Override
  public String handleRequest(Void input, Context context) {

    var message = "Hello World!";


    return message;
  }
}
