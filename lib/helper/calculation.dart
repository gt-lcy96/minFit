import 'dart:math';

double calculateAverage(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0; // Handle the case when the list is empty to avoid division by zero
  }

  var sum = numbers.reduce((a, b) => a + b);
  return sum / numbers.length;
}

double calculateStandardDeviation(List<double> data) {
  // Compute the mean (average) of the data set
  double mean = data.reduce((a, b) => a + b) / data.length;

  // Compute the squared differences from the mean
  var squaredDifferences = data.map((value) => pow(value - mean, 2));

  // Compute the average of the squared differences (variance)
  double variance =
      squaredDifferences.reduce((a, b) => a + b) / (data.length - 1);

  // Take the square root of the variance to get the standard deviation
  double standardDeviation = sqrt(variance);

  return standardDeviation;
}

double find_max_in_list(List<double> numbers) {
  return numbers.reduce(
      (double value, double element) => value > element ? value : element);
}

double find_min_in_list(List<double> numbers) {
  return numbers.reduce(
      (double value, double element) => value < element ? value : element);
}
