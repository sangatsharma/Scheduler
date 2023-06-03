/* VALIDATION LOGIC FOR ALL LOGIN FORMS*/

bool loginUser(formKey){
  // Run validate code for respective forms
  // The form key is used to determine which form is it.
  if(formKey.currentState!.validate()){
    return true;
  }
  return false;
}