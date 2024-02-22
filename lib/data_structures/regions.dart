import 'package:green_zone/data_structures/country.dart';
import 'package:hive/hive.dart';

part 'regions.g.dart';

@HiveType(typeId: 1)
class Region {
  // Unchangeable Variables

  @HiveField(0)
  String name;

  @HiveField(1)
  final List<int> adjacentRegions;

  @HiveField(2)
  List<Country> countries;

  @HiveField(3)
  bool isActive;

  @HiveField(4)
  bool canSail;

  @HiveField(5)
  bool hasBubble;

  Region(
      {required this.countries,
      required this.name,
      required this.adjacentRegions,
      this.canSail = false,
      this.hasBubble = false,
      this.isActive = false});
}

List<Region> regions = [
  Region(
    adjacentRegions: [1],
    countries: [
      Country(name: "United States", abbreviation: "us", maximumEnergy: 1000),
      Country(name: "Canada", abbreviation: "ca", maximumEnergy: 750),
    ],
    name: "North America",
  ),
  Region(
    adjacentRegions: [0, 2],
    name: "Central America",
    countries: [
      //Central American Countries
      Country(name: "Belize", abbreviation: "bz"),
      Country(name: "Costa Rica", abbreviation: "cr"),
      Country(name: "El Salvador", abbreviation: "sv"),
      Country(name: "Guatemala", abbreviation: "gt"),
      Country(name: "Honduras", abbreviation: "hn"),
      Country(name: "Mexico", abbreviation: "mx", maximumEnergy: 750),
      Country(name: "Nicaragua", abbreviation: "ni"),
      Country(name: "Panama", abbreviation: "pa"),

      //Caribbean Islands
      Country(name: "Antigua and Barbuda", abbreviation: "ag"),
      Country(name: "The Bahamas", abbreviation: "bs"),
      Country(name: "Barbados", abbreviation: "bb"),
      Country(name: "Cuba", abbreviation: "cu"),
      Country(name: "Dominica", abbreviation: "dm"),
      Country(name: "Dominican Republic", abbreviation: "do"),
      Country(name: "Grenada", abbreviation: "gd"),
      Country(name: "Haiti", abbreviation: "ht"),
      Country(name: "Jamaica", abbreviation: "jm"),
      Country(name: "Saint Kitts and Nevis", abbreviation: "kn"),
      Country(name: "Saint Lucia", abbreviation: "lc"),
      Country(name: "Saint Vincent and the Grenadines", abbreviation: "vc"),
      Country(name: "Puerto Rico", abbreviation: "pr"),
    ],
  ),
  Region(
    adjacentRegions: [1],
    name: "South America",
    countries: [
      Country(name: "Argentina", abbreviation: "ar"),
      Country(name: "Bolivia", abbreviation: "bo"),
      Country(name: "Brazil", abbreviation: "br", maximumEnergy: 1000),
      Country(name: "Chile", abbreviation: "cl"),
      Country(name: "Colombia", abbreviation: "co"),
      Country(name: "Ecuador", abbreviation: "ec"),
      Country(name: "Falkland Islands", abbreviation: "fk"),
      Country(name: "French Guiana", abbreviation: "gf"),
      Country(name: "Guyana", abbreviation: "gy"),
      Country(name: "Paraguay", abbreviation: "py"),
      Country(name: "Peru", abbreviation: "pe"),
      Country(name: "Suriname", abbreviation: "sr"),
      Country(name: "Uruguay", abbreviation: "uy"),
      Country(name: "Venezuela", abbreviation: "ve"),
    ],
  ),
  Region(
    name: "Europe",
    adjacentRegions: [4, 5, 9],
    countries: [
      Country(name: "Andorra", abbreviation: "ad"),
      Country(name: "Austria", abbreviation: "at"),
      Country(name: "Belgium", abbreviation: "be"),
      Country(name: "Denmark", abbreviation: "dk"),
      Country(name: "Finland", abbreviation: "fi"),
      Country(name: "France", abbreviation: "fr"),
      Country(name: "Germany", abbreviation: "de", maximumEnergy: 750),
      Country(name: "Greenland", abbreviation: "gl"),
      Country(name: "Iceland", abbreviation: "is"),
      Country(name: "Ireland", abbreviation: "ie"),
      Country(name: "Italy", abbreviation: "it"),
      Country(name: "Liechtenstein", abbreviation: "li"),
      Country(name: "Luxembourg", abbreviation: "lu"),
      Country(name: "Monaco", abbreviation: "mc"),
      Country(name: "Netherlands", abbreviation: "nl"),
      Country(name: "Norway", abbreviation: "no"),
      Country(name: "Portugal", abbreviation: "pt"),
      Country(name: "San Marino", abbreviation: "sm"),
      Country(name: "Spain", abbreviation: "es", maximumEnergy: 750),
      Country(name: "Svalbard and Jan Mayen	", abbreviation: "sj"),
      Country(name: "Sweden", abbreviation: "se"),
      Country(name: "Switzerland", abbreviation: "ch"),
      Country(name: "United Kingdom", abbreviation: "gb", maximumEnergy: 750),
      Country(name: "Vatican City", abbreviation: "va"),

      // Added Eastern Europe for better clickablilty
      Country(name: "Bulgaria", abbreviation: "bg"),
      Country(name: "Czech Republic", abbreviation: "cz"),
      Country(name: "Hungary", abbreviation: "hu"),
      Country(name: "Moldova", abbreviation: "md"),
      Country(name: "Poland", abbreviation: "pl"),
      Country(name: "Romania", abbreviation: "ro"),
      Country(name: "Slovakia", abbreviation: "sk"),
      Country(name: "Albania", abbreviation: "al"),
      Country(name: "Bosnia and Herzegovina", abbreviation: "ba"),
      Country(name: "Croatia", abbreviation: "hr"),
      Country(name: "Montenegro", abbreviation: "me"),
      Country(name: "North Macedonia", abbreviation: "mk"),
      Country(name: "Serbia", abbreviation: "rs"),
      Country(name: "Slovenia", abbreviation: "si"),
      Country(name: "Greece", abbreviation: "gr"),
      Country(name: "Cyprus", abbreviation: "cy"),
      Country(name: "Malta", abbreviation: "mt"),
    ],
  ),
  Region(
    name: "Middle East",
    adjacentRegions: [3, 5, 9, 10, 12],
    countries: [
      Country(name: "Bahrain", abbreviation: "bh"),
      Country(name: "Cyprus", abbreviation: "cy"),
      Country(name: "Iran", abbreviation: "ir"),
      Country(name: "Iraq", abbreviation: "iq"),
      Country(name: "Israel", abbreviation: "il"),
      Country(name: "Jordan", abbreviation: "jo"),
      Country(name: "Kuwait", abbreviation: "kw"),
      Country(name: "Lebanon", abbreviation: "lb"),
      Country(name: "Oman", abbreviation: "om"),
      Country(name: "Palestine", abbreviation: "ps"),
      Country(name: "Qatar", abbreviation: "qa"),
      Country(name: "Saudi Arabia", abbreviation: "sa"),
      Country(name: "Syria", abbreviation: "sy"),
      Country(name: "Turkey", abbreviation: "tr"),
      Country(name: "United Arab Emirates", abbreviation: "ae"),
      Country(name: "Yemen", abbreviation: "ye"),
    ],
  ),
  Region(
    name: "Northern Africa",
    adjacentRegions: [3, 4, 6, 8],
    countries: [
      Country(name: "Algeria", abbreviation: "dz"),
      Country(name: "Chad", abbreviation: "td"),
      Country(name: "Egypt", abbreviation: "eg"),
      Country(name: "Libya", abbreviation: "ly"),
      Country(name: "Morocco", abbreviation: "ma"),
      Country(name: "Sudan", abbreviation: "sd"),
      Country(name: "Tunisia", abbreviation: "tn"),
      Country(name: "Western Sahara", abbreviation: "eh"),
    ],
  ),
  Region(
    name: "Western Africa",
    adjacentRegions: [5, 7, 8],
    countries: [
      Country(name: "Benin", abbreviation: "bj"),
      Country(name: "Burkina Faso", abbreviation: "bf"),
      Country(name: "Cape Verde", abbreviation: "cv"),
      Country(name: "Côte d'Ivoire", abbreviation: "ci"),
      Country(name: "Gambia", abbreviation: "gm"),
      Country(name: "Ghana", abbreviation: "gh"),
      Country(name: "Guinea", abbreviation: "gn"),
      Country(name: "Guinea-Bissau", abbreviation: "gw"),
      Country(name: "Liberia", abbreviation: "lr"),
      Country(name: "Mali", abbreviation: "ml"),
      Country(name: "Mauritania", abbreviation: "mr"),
      Country(name: "Niger", abbreviation: "ne"),
      Country(name: "Nigeria", abbreviation: "ng"),
      Country(name: "Senegal", abbreviation: "sn"),
      Country(name: "Sierra Leone", abbreviation: "sl"),
      Country(name: "Togo", abbreviation: "tg"),
    ],
  ),
  Region(
    name: "Southern Africa",
    adjacentRegions: [5, 6, 8],
    countries: [
      Country(name: "Angola", abbreviation: "ao"),
      Country(name: "Botswana", abbreviation: "bw"),
      Country(name: "Lesotho", abbreviation: "ls"),
      Country(name: "Madagascar", abbreviation: "mg"),
      Country(name: "Malawi", abbreviation: "mw"),
      Country(name: "Mozambique", abbreviation: "mz"),
      Country(name: "Namibia", abbreviation: "na"),
      Country(name: "South Africa", abbreviation: "za"),
      Country(name: "Swaziland (Eswatini)", abbreviation: "sz"),
      Country(name: "Zambia", abbreviation: "zm"),
      Country(name: "Zimbabwe", abbreviation: "zw"),
    ],
  ),
  Region(
    name: "Central Africa",
    adjacentRegions: [4, 5, 6, 7],
    countries: [
      Country(name: "Burundi", abbreviation: "bi"),
      Country(name: "Cameroon", abbreviation: "cm"),
      Country(name: "Central African Republic", abbreviation: "cf"),
      Country(name: "Congo (Brazzaville)", abbreviation: "cg"),
      Country(name: "Congo (Kinshasa)", abbreviation: "cd"),
      Country(name: "Djibouti", abbreviation: "dj"),
      Country(name: "Equatorial Guinea", abbreviation: "gq"),
      Country(name: "Ethiopia", abbreviation: "et"),
      Country(name: "Eritrea", abbreviation: "er"),
      Country(name: "Gabon", abbreviation: "ga"),
      Country(name: "Rwanda", abbreviation: "rw"),
      Country(name: "Sao Tome and Principe", abbreviation: "st"),
      Country(name: "Somalia", abbreviation: "so"),
      Country(name: "South Sudan", abbreviation: "ss"),
      Country(name: "Tanzania", abbreviation: "tz"),
      Country(name: "Uganda", abbreviation: "ug"),
      Country(name: "Kenya", abbreviation: "ke"),
    ],
  ),
  Region(
    name: "Siberia",
    adjacentRegions: [3, 4, 10, 11],
    countries: [
      Country(name: "Armenia", abbreviation: "am"),
      Country(name: "Azerbaijan", abbreviation: "az"),
      Country(name: "Belarus", abbreviation: "by"),
      Country(name: "Estonia", abbreviation: "ee"),
      Country(name: "Estonia", abbreviation: "ee"),
      Country(name: "Georgia", abbreviation: "ge"),
      Country(name: "Latvia", abbreviation: "lv"),
      Country(name: "Lithuania", abbreviation: "lt"),
      Country(name: "Russia", abbreviation: "ru", maximumEnergy: 1000),
      Country(name: "Ukraine", abbreviation: "ua"),
    ],
  ),
  Region(
    name: "Cental Asia",
    adjacentRegions: [4, 9, 11, 12],
    countries: [
      Country(name: "Afghanistan", abbreviation: "af"),
      Country(name: "Kazakhstan", abbreviation: "kz"),
      Country(name: "Kyrgyzstan", abbreviation: "kg"),
      Country(name: "Tajikistan", abbreviation: "tj"),
      Country(name: "Turkmenistan", abbreviation: "tm"),
      Country(name: "Uzbekistan", abbreviation: "uz"),
    ],
  ),
  Region(
    name: "East Asia",
    adjacentRegions: [9, 10, 12],
    countries: [
      Country(name: "China", abbreviation: "cn", maximumEnergy: 1000),
      Country(name: "Japan", abbreviation: "jp", maximumEnergy: 750),
      Country(name: "Mongolia", abbreviation: "mn"),
      Country(name: "North Korea", abbreviation: "kp"),
      Country(name: "South Korea", abbreviation: "kr"),
      Country(name: "Taiwan", abbreviation: "tw"),
      Country(name: "Hong Kong", abbreviation: "hk"),
      Country(name: "Macao", abbreviation: "mo"),
    ],
  ),
  Region(
    name: "South Asia",
    adjacentRegions: [4, 10, 11],
    countries: [
      Country(name: "Bangladesh", abbreviation: "bd"),
      Country(name: "Bhutan", abbreviation: "bt"),
      Country(name: "India", abbreviation: "in", maximumEnergy: 1000),
      Country(name: "Maldives", abbreviation: "mv"),
      Country(name: "Nepal", abbreviation: "np"),
      Country(name: "Pakistan", abbreviation: "pk"),
      Country(name: "Sri Lanka", abbreviation: "lk"),

      //Adding SouthEaster Asian countries for simplicity
      Country(name: "Cambodia", abbreviation: "kh"),
      Country(name: "Laos", abbreviation: "la"),
      Country(name: "Myanmar (Burma)", abbreviation: "mm"),
      Country(name: "Singapore", abbreviation: "sg"),
      Country(name: "Thailand", abbreviation: "th"),
      Country(name: "Vietnam", abbreviation: "vn"),
    ],
  ),
  Region(
    name: "Oceana",
    canSail: true,
    adjacentRegions: [],
    countries: [
      Country(name: "Australia", abbreviation: "au", maximumEnergy: 1000),
      Country(name: "Brunei", abbreviation: "bn"),
      Country(name: "East Timor (Timor-Leste)", abbreviation: "tl"),
      Country(name: "Fiji", abbreviation: "fj"),
      Country(name: "Indonesia", abbreviation: "id"),
      Country(name: "Kiribati", abbreviation: "ki"),
      Country(name: "Malaysia", abbreviation: "my"),
      Country(name: "Marshall Islands", abbreviation: "mh"),
      Country(name: "Micronesia", abbreviation: "fm"),
      Country(name: "Nauru", abbreviation: "nr"),
      Country(name: "New Caledonia", abbreviation: "nc"),
      Country(name: "New Zealand", abbreviation: "nz"),
      Country(name: "Palau", abbreviation: "pw"),
      Country(name: "Papua New Guinea", abbreviation: "pg"),
      Country(name: "Philippines", abbreviation: "ph"),
      Country(name: "Samoa", abbreviation: "ws"),
      Country(name: "Solomon Islands", abbreviation: "sb"),
      Country(name: "Tonga", abbreviation: "to"),
      Country(name: "Tuvalu", abbreviation: "tv"),
      Country(name: "Vanuatu", abbreviation: "vu"),
    ],
  ),
  Region(
    name: "Za Wardo",
    adjacentRegions: [],
    countries: [
      Country(
        name: "",
        abbreviation: "",
      ),
    ],
  ),
];
