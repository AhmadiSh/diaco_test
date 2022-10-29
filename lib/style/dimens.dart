import 'package:flutter/material.dart';

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double standardSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 26;
  } else {
    return MediaQuery.of(context).size.width / 16;
  }
}

double largeSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 22;
  } else {
    return MediaQuery.of(context).size.width / 12;
  }
}

double xlargeSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 18;
  }
  return MediaQuery.of(context).size.width / 6;
}

double xxLargeSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 13;
  }
  return MediaQuery.of(context).size.width / 3;
}

double mediumSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 32;
  }
  return MediaQuery.of(context).size.width / 22;
}

double smallSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 40;
  } else {
    return MediaQuery.of(context).size.width / 30;
  }
}

double xSmallSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 48;
  } else {
    return MediaQuery.of(context).size.width / 38;
  }
}

double xxSmallSize(BuildContext context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 90;
  } else {
    return MediaQuery.of(context).size.width / 80;
  }
}

double iconSize(context) {
  if (MediaQuery.of(context).size.width > 600) {
    return MediaQuery.of(context).size.width / 34;
  } else {
    return MediaQuery.of(context).size.width / 22;
  }
}