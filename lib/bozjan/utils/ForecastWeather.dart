// calculateForecastTarget: function(lDate) {

int forecastWeather(int lDate) {
  // Thanks to Rogueadyn's SaintCoinach library for this calculation.
  // lDate is the current local time.

  // TODO: Make a unit test for this. You can already check output by doing return unixTime.
  int unixTime = (lDate / 1000).toInt();

  // Get Eorzea hour for weather start
  var bell = unixTime / 175;

  // Do the magic 'cause for calculations 16:00 is 0, 00:00 is 8 and 08:00 is 16
  var increment = (bell + 8 - (bell % 8)) % 24;

  // Take Eorzea days since unix epoch
  int totalDays = (unixTime / 4200).toInt();
  // totalDays = (totalDays << 32) >>> 0; // Original
  // totalDays = ((totalDays << 32) & 0xFFFFFFFF) >> 0; // Convert to uint -- Note I have no idea why I had to disable this.

  // 0x64 = 100
  int calcBase = totalDays * 100 + increment.toInt();

  // 0xB = 11
  var step1 = (calcBase << 11) ^ calcBase;
  // var step2 = (step1 >>> 8) ^ step1; // Original
  // Dart doesnt have >>> so using this https://stackoverflow.com/questions/11746504/how-to-do-zero-fill-right-shift-in-dart/11748886
  var step2 = ((step1 & 0xFFFFFFFF) >> 8) ^ step1;

  // 0x64 = 100
  return step2 % 100;
}
