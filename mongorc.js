
prompt = function() {
  if (typeof db != "undefined")
    return db.getName() + " >";
  return " >";
}
