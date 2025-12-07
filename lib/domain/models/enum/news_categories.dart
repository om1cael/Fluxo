enum NewsCategories { 
  general("General"), 
  technology("Technology"), 
  science("Science"), 
  entertainment("Entertainment"), 
  sports("Sports"), 
  health("Health"), 
  business("Business");

  const NewsCategories(this.frontEndName);

  final String frontEndName;
}