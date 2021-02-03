function populateNewDay() {
  var sheet = SpreadsheetApp.getActiveSheet();
  // Grab "current" date and create Date variable for subsequent day
  var latestDay = new Date(sheet.getRange("A2").getValues());
  var nextDay = new Date(latestDay);
  nextDay.setDate(nextDay.getDate()+1);
  
  // Copy and paste data to make space for new day of practice
  var lastRow = sheet.getLastRow();
  var sourceRange = sheet.getRange("A2:R"+(lastRow));
  var targetRange = sheet.getRange("A9:R"+(lastRow+7));
  sourceRange.copyTo(targetRange);
  
  // The new "current" date needs to be incremented by one
  var latestDayCell = sheet.getRange("A2");
  latestDayCell.setValue(nextDay);

  // Clear all start/end/duration data that was copied over from the previous day
  var oldData = sheet.getRange("D2:F7")
  var olddata2 = sheet.getRange("L2:Q7")
  oldData.clearContent();
  olddata2.clearContent();
}