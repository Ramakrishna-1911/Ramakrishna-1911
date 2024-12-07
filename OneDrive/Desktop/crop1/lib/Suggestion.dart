import 'package:flutter/material.dart';

class CropSuggestionApp extends StatelessWidget {
  const CropSuggestionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CropSuggestionScreen(),
    );
  }
}

class CropSuggestionScreen extends StatefulWidget {
  const CropSuggestionScreen({super.key});

  @override
  State<CropSuggestionScreen> createState() => _CropSuggestionScreenState();
}

class _CropSuggestionScreenState extends State<CropSuggestionScreen> {
  final TextEditingController searchController = TextEditingController();

  // Local database as a list of maps
  final List<Map<String, String>> cropDatabase = [
  {
    'Crop Name': 'Rice',
    'Usage': 'Composting for soil fertility, Biogas generation, Mushroom cultivation',
    'Wastage': 'Straw, Husk',
  },
  {
    'Crop Name': 'Sugarcane',
    'Usage': 'Bioethanol production, Paper and tableware production, Craft materials',
    'Wastage': 'Bagasse, Leaves',
  },
  {
    'Crop Name': 'Corn',
    'Usage': 'Animal feed production, Bioenergy generation, Mulching for moisture retention',
    'Wastage': 'Stover, Cobs',
  },
  {
    'Crop Name': 'Wheat',
    'Usage': 'Composting for soil improvement, Biofuel production, Packing material',
    'Wastage': 'Straw',
  },
  {
    'Crop Name': 'Banana',
    'Usage': 'Composting for organic fertilizer, Fiber extraction for textiles, Animal feed',
    'Wastage': 'Peels, Stems',
  },
  {
    'Crop Name': 'Potato',
    'Usage': 'Animal feed, Starch recovery, Compost and mulch',
    'Wastage': 'Peels, Starch Residues',
  },
  {
    'Crop Name': 'Soybean',
    'Usage': 'Biodiesel production, Animal feed, Soil fertility',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Cotton',
    'Usage': 'Textile industry, Paper production, Bioenergy generation',
    'Wastage': 'Stalks, Lint',
  },
  {
    'Crop Name': 'Tomato',
    'Usage': 'Composting, Bioenergy generation, Animal feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Mango',
    'Usage': 'Oil extraction from seeds, Food processing waste reuse, Compost and mulch',
    'Wastage': 'Seeds, Skins',
  },
  {
    'Crop Name': 'Coconut',
    'Usage': 'Activated carbon production, Craft materials, Bedding material',
    'Wastage': 'Shells, Husks',
  },
  {
    'Crop Name': 'Groundnut',
    'Usage': 'Oil extraction, Animal feed, Bioenergy',
    'Wastage': 'Shells, Husks',
  },
  {
    'Crop Name': 'Tea',
    'Usage': 'Composting, Mulch production, Tea residue reuse',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Coffee',
    'Usage': 'Compost and biochar, Animal feed, Industrial applications',
    'Wastage': 'Pulp, Husks',
  },
  {
    'Crop Name': 'Palm',
    'Usage': 'Biofuel and mulch, Oil production, Bedding material',
    'Wastage': 'Fronds, Kernels',
  },
  {
    'Crop Name': 'Barley',
    'Usage': 'Composting, Animal bedding, Mulching',
    'Wastage': 'Hulls, Straw',
  },
  {
    'Crop Name': 'Oats',
    'Usage': 'Composting, Animal bedding, Soil amendment',
    'Wastage': 'Hulls, Straw',
  },
  {
    'Crop Name': 'Sorghum',
    'Usage': 'Bioenergy production, Animal feed, Composting',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Millet',
    'Usage': 'Animal feed, Mulching, Bioenergy production',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Rye',
    'Usage': 'Bioenergy generation, Animal bedding, Composting',
    'Wastage': 'Straw, Chaff',
  },
  {
    'Crop Name': 'Quinoa',
    'Usage': 'Composting, Soil fertility enhancement, Biochar production',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Teff',
    'Usage': 'Composting, Mulching, Animal feed',
    'Wastage': 'Straw, Chaff',
  },
  {
    'Crop Name': 'Buckwheat',
    'Usage': 'Animal feed, Soil fertility, Composting',
    'Wastage': 'Hulls, Straw',
  },
  {
    'Crop Name': 'Amaranth',
    'Usage': 'Soil amendment, Animal feed, Mulching',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Spelt',
    'Usage': 'Bioenergy production, Animal bedding, Soil amendment',
    'Wastage': 'Hulls, Straw',
  },
  {
    'Crop Name': 'Triticale',
    'Usage': 'Animal feed, Soil amendment, Composting',
    'Wastage': 'Straw, Leaves',
  },
  {
    'Crop Name': 'Fonio',
    'Usage': 'Bioenergy production, Animal feed, Mulching',
    'Wastage': 'Straw, Leaves',
  },
  {
    'Crop Name': 'Soybeans',
    'Usage': 'Biodiesel production, Soil fertility, Biochar production',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Chickpeas',
    'Usage': 'Animal feed, Soil amendment, Biochar production',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Lentils',
    'Usage': 'Composting, Soil fertility, Biochar production',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Peas',
    'Usage': 'Animal feed, Biochar production, Composting',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Black-eyed peas',
    'Usage': 'Composting, Biochar production, Animal feed',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Kidney beans',
    'Usage': 'Animal feed, Soil fertility, Composting',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Pinto beans',
    'Usage': 'Bioenergy generation, Composting, Animal feed',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Navy beans',
    'Usage': 'Animal feed, Biochar production, Composting',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Broad beans',
    'Usage': 'Animal feed, Biochar production, Composting',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Green grams (Moong)',
    'Usage': 'Composting, Animal feed, Soil amendment',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Pigeon peas (Toor)',
    'Usage': 'Biochar production, Soil fertility enhancement, Animal bedding',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Lima beans',
    'Usage': 'Animal feed, Composting, Soil amendment',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Cowpeas',
    'Usage': 'Composting, Soil fertility enhancement, Animal bedding',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Adzuki beans',
    'Usage': 'Animal feed, Bioenergy production, Biochar production',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Lupins',
    'Usage': 'Animal feed, Soil fertility enhancement, Animal bedding',
    'Wastage': 'Pods, Stalks',
  },
  {
    'Crop Name': 'Sunflower',
    'Usage': 'Oil extraction, Bioenergy production, Animal bedding',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Rapeseed (Canola)',
    'Usage': 'Oil extraction, Animal feed, Composting',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Mustard',
    'Usage': 'Oil extraction, Animal feed, Biochar production',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Sesame',
    'Usage': 'Oil extraction, Animal feed, Composting',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Flaxseed',
    'Usage': 'Oil extraction, Composting, Biochar production',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Safflower',
    'Usage': 'Oil extraction, Composting, Biochar production',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Castor',
    'Usage': 'Biodiesel production, Composting, Soil amendment',
    'Wastage': 'Hulls, Stalks',
  },
  {
    'Crop Name': 'Apples',
    'Usage': 'Animal feed, Biochar production, Composting',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Oranges',
    'Usage': 'Juice production by-products, Animal feed, Soil amendment',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Grapes',
    'Usage': 'Composting, Mulching, Biochar production',
    'Wastage': 'Pomace, Stalks',
  },
  {
    'Crop Name': 'Pineapples',
    'Usage': 'Bioenergy production, Mulching, Animal bedding',
    'Wastage': 'Peels, Leaves',
  },
  {
    'Crop Name': 'Watermelons',
    'Usage': 'Composting, Animal feed, Biochar production',
    'Wastage': 'Rinds',
  },
  {
    'Crop Name': 'Lemons',
    'Usage': 'Juice production by-products, Animal feed, Biochar production',
    'Wastage': 'Rinds',
  },
  {
    'Crop Name': 'Papayas',
    'Usage': 'Composting, Animal feed, Biochar production',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Pears',
    'Usage': 'Biochar production, Composting, Biochar production',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Guavas',
    'Usage': 'Biochar production, Composting, Biochar production',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Peaches',
    'Usage': 'Juice production by-products, Composting, Animal feed',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Plums',
    'Usage': 'Biochar production, Animal feed, Biochar production',
    'Wastage': 'Peels, Pomace',
  },
  {
    'Crop Name': 'Apricots',
    'Usage': 'Phenolic compound extraction, Cosmetic applications, Nutraceutical uses',
    'Wastage': 'Kernels, Pulp',
  },
  {
    'Crop Name': 'Avocados',
    'Usage': 'Biofuel production, Animal feed, Food additives',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Lychees',
    'Usage': 'Antioxidant extraction, Pharmaceutical uses, Bioactive compound production',
    'Wastage': 'Seeds, Peels',
  },
  {
    'Crop Name': 'Pomegranates',
    'Usage': 'Natural dye production, Bio-preservatives, Cosmetic applications',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Cherries',
    'Usage': 'Tea production, Oil extraction, Composting',
    'Wastage': 'Stems, Pits',
  },
  {
    'Crop Name': 'Strawberries',
    'Usage': 'Antioxidant extraction, Composting, Animal feed',
    'Wastage': 'Leaves, Pomace',
  },
  {
    'Crop Name': 'Blueberries',
    'Usage': 'Bioactive compound extraction, Composting, Food supplements',
    'Wastage': 'Leaves, Pomace',
  },
  {
    'Crop Name': 'Dates',
    'Usage': 'Bioethanol production, Animal feed, Charcoal production',
    'Wastage': 'Pits, Fibers',
  },
  {
    'Crop Name': 'Figs',
    'Usage': 'Phenolic compound extraction, Composting, Animal feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Kiwis',
    'Usage': 'Nutraceutical production, Animal feed, Bioactive compound extraction',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Onions',
    'Usage': 'Flavonoid extraction, Composting, Bio-preservatives',
    'Wastage': 'Skins, Peels',
  },
  {
    'Crop Name': 'Garlic',
    'Usage': 'Antioxidant extraction, Composting, Pharmaceutical uses',
    'Wastage': 'Skins, Peels',
  },
  {
    'Crop Name': 'Carrots',
    'Usage': 'Composting, Animal feed, Bioplastics production',
    'Wastage': 'Tops, Peels',
  },
  {
    'Crop Name': 'Beets',
    'Usage': 'Food coloring, Composting, Animal feed',
    'Wastage': 'Leaves, Roots',
  },
  {
    'Crop Name': 'Cabbages',
    'Usage': 'Composting, Animal feed, Bio-preservatives',
    'Wastage': 'Outer leaves',
  },
  {
    'Crop Name': 'Cauliflowers',
    'Usage': 'Composting, Animal feed, Bioplastics production',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Broccoli',
    'Usage': 'Bioactive compound extraction, Composting, Animal feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Spinach',
    'Usage': 'Composting, Bioactive compound extraction, Animal feed',
    'Wastage': 'Leaves',
  },
  {
    'Crop Name': 'Eggplants (Brinjals)',
    'Usage': 'Composting, Animal feed, Bioactive compound extraction',
    'Wastage': 'Stems, Peels',
  },
  {
    'Crop Name': 'Peppers (Capsicums)',
    'Usage': 'Capsaicin extraction, Composting, Animal feed',
    'Wastage': 'Stems, Seeds',
  },
  {
    'Crop Name': 'Cucumbers',
    'Usage': 'Bioactive compound extraction, Composting, Animal feed',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Pumpkins',
    'Usage': 'Pectin production, Bioplastics, Animal feed',
    'Wastage': 'Seeds, Shells',
  },
  {
    'Crop Name': 'Squash',
    'Usage': 'Composting, Animal feed, Bioactive compound extraction',
    'Wastage': 'Peels, Seeds',
  },

  {
    'Crop Name': 'Okra',
    'Usage': 'Mucilage extraction, Composting, Bioactive compound extraction',
    'Wastage': 'Stems, Seeds',
  },
  {
    'Crop Name': 'Sweet Potatoes',
    'Usage': 'Animal feed, Composting, Bioactive compound extraction',
    'Wastage': 'Peels, Leaves, Vines',
  },
  {
    'Crop Name': 'Radishes',
    'Usage': 'Animal feed, Composting, Nutritional powders',
    'Wastage': 'Leaves, Trimmings',
  },
  {
    'Crop Name': 'Turnips',
    'Usage': 'Culinary uses (greens), Animal feed, Fermentation',
    'Wastage': 'Greens, Peels',
  },
  {
    'Crop Name': 'Zucchini',
    'Usage': 'Bioenergy production, Composting, Dietary fiber production',
    'Wastage': 'Skins, Seeds, Unmarketable fruit',
  },
  {
    'Crop Name': 'Leeks',
    'Usage': 'Composting, Bioenergy systems, Paper/biodegradable products',
    'Wastage': 'Outer leaves, Trimmings',
  },
  {
    'Crop Name': 'Lettuce',
    'Usage': 'Composting, Bioenergy systems, Antioxidant extraction',
    'Wastage': 'Leaves, Cores',
  },
  {
    'Crop Name': 'Celery',
    'Usage': 'Animal feed, Composting, Juice extraction',
    'Wastage': 'Stalk trimmings, Leaves',
  },
  {
    'Crop Name': 'Kale',
    'Usage': 'Animal feed, Composting, Powders for supplements',
    'Wastage': 'Stems, Damaged leaves',
  },
  {
    'Crop Name': 'Asparagus',
    'Usage': 'Bioenergy production, Composting, Antioxidant extraction',
    'Wastage': 'Trimmings, Lower stalks',
  },
  {
    'Crop Name': 'Jute',
    'Usage': 'Paper production, Biocomposites, Biomass energy',
    'Wastage': 'Retting residues, Fibers',
  },
  {
    'Crop Name': 'Hemp',
    'Usage': 'Bio-composites, Insulation material, Textiles',
    'Wastage': 'Stalks, Leaves, Roots, Fibers',
  },
  {
    'Crop Name': 'Flax',
    'Usage': 'Paper manufacturing, Insulation panels, Bio-based plastics',
    'Wastage': 'Flax shives, Seeds, Fibers',
  },
  {
    'Crop Name': 'Kenaf',
    'Usage': 'Paper pulp, Bio-composites, Soil remediation',
    'Wastage': 'Stems, Fibers',
  },
  {
    'Crop Name': 'Ramie',
    'Usage': 'Textiles, Biodegradable packaging, Organic mulch',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Sisal',
    'Usage': 'Ropes, Rugs, Composite materials',
    'Wastage': 'Fibers, Leaves',
  },
  {
    'Crop Name': 'Agave',
    'Usage': 'Bioplastics, Paper, Natural sweeteners',
    'Wastage': 'Leaves, Fibers, Pulp',
  },
  {
    'Crop Name': 'Bamboo',
    'Usage': 'Construction material, Paper, Biochar',
    'Wastage': 'Shoots, Leaves, Roots, Sawdust',
  },
  {
    'Crop Name': 'Cocoa',
    'Usage': 'Organic fertilizers, Bio-charcoal, Animal feed',
    'Wastage': 'Pods, Shells, Mucilage',
  },
  {
    'Crop Name': 'Tobacco',
    'Usage': 'Bio-pesticides, Nicotine extraction, Biochar',
    'Wastage': 'Stems, Leaves, Dust',
  },
  {
    'Crop Name': 'Rubber',
    'Usage': 'Rubber recycling, Biofuels, Organic mulch',
    'Wastage': 'Latex scraps, Bark, Leaves',
  },
 {
    'Crop Name': 'Vanilla',
    'Usage': 'Composting, Biochar Production, Soil Amendment',
    'Wastage': 'Pods, Stems',
  },
  {
    'Crop Name': 'Pepper (Black and Green)',
    'Usage': 'Composting, Animal Feed, Bioenergy Production',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Cardamom',
    'Usage': 'Essential Oil Extraction, Composting, Biochar Production',
    'Wastage': 'Husks, Leaves',
  },
  {
    'Crop Name': 'Nutmeg',
    'Usage': 'Composting, Soil Fertility Enhancement, Animal Bedding',
    'Wastage': 'Shells, Husks',
  },
  {
    'Crop Name': 'Clove',
    'Usage': 'Composting, Bioenergy Production, Essential Oil Extraction',
    'Wastage': 'Stems, Leaves',
  },
  {
    'Crop Name': 'Cinnamon',
    'Usage': 'Composting, Biochar Production, Soil Amendment',
    'Wastage': 'Bark, Leaves',
  },
  {
    'Crop Name': 'Areca Nut',
    'Usage': 'Bioenergy Production, Composting, Animal Feed',
    'Wastage': 'Husks, Shells',
  },
  {
    'Crop Name': 'Cashew',
    'Usage': 'Bioenergy Production, Soil Amendment, Composting',
    'Wastage': 'Shells, Husks',
  },
  {
    'Crop Name': 'Almond',
    'Usage': 'Animal Feed, Bioenergy Production, Composting',
    'Wastage': 'Shells, Husks',
  },
  {
    'Crop Name': 'Turmeric',
    'Usage': 'Composting, Essential Oil Extraction, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Rhizomes',
  },
  {
    'Crop Name': 'Ginger',
    'Usage': 'Composting, Bioenergy Production, Soil Fertility Enhancement',
    'Wastage': 'Rhizomes, Leaves',
  },
  {
    'Crop Name': 'Coriander',
    'Usage': 'Composting, Biochar Production, Animal Feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Fenugreek',
    'Usage': 'Animal Feed, Soil Fertility Enhancement, Bioenergy Production',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Cumin',
    'Usage': 'Essential Oil Extraction, Composting, Biochar Production',
    'Wastage': 'Stems, Husks',
  },
  {
    'Crop Name': 'Basil',
    'Usage': 'Composting, Soil Amendment, Animal Feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Thyme',
    'Usage': 'Essential Oil Extraction, Biochar Production, Composting',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Mint',
    'Usage': 'Composting, Essential Oil Extraction, Bioenergy Production',
    'Wastage': 'Leaves',
  },
  {
    'Crop Name': 'Parsley',
    'Usage': 'Composting, Soil Fertility Enhancement, Animal Feed',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Oregano',
    'Usage': 'Composting, Biochar Production, Composting',
    'Wastage': 'Leaves',
  },
  {
    'Crop Name': 'Cassava',
    'Usage': 'Animal Feed, Bioenergy Production, Composting',
    'Wastage': 'Peels, Stems',
  },
  {
    'Crop Name': 'Yam',
    'Usage': 'Composting, Biochar Production, Soil Fertility Enhancement',
    'Wastage': 'Peels, Stems',
  },
 {
    'Crop Name': 'Taro',
    'Usage': 'Animal Feed, Composting, Bioenergy Production',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Arrowroot',
    'Usage': 'Composting, Soil Fertility Enhancement, Animal Feed',
    'Wastage': 'Peels, Stems',
  },
  {
    'Crop Name': 'Parsnips',
    'Usage': 'Animal Feed, Biochar Production, Composting',
    'Wastage': 'Leaves, Peels',
  },
  {
    'Crop Name': 'Lotus Root',
    'Usage': 'Composting, Soil Amendment, Biochar Production',
    'Wastage': 'Peels, Stems',
  },
  {
    'Crop Name': 'Jerusalem Artichokes',
    'Usage': 'Bioenergy Production, Composting, Soil Fertility Enhancement',
    'Wastage': 'Peels, Stems',
  },
  {
    'Crop Name': 'Konjac',
    'Usage': 'Bioenergy Production, Soil Fertility Enhancement, Animal Feed',
    'Wastage': 'Leaves, Peels',
  },
  {
    'Crop Name': 'Horseradish',
    'Usage': 'Composting, Soil Fertility Enhancement, Bioenergy Production',
    'Wastage': 'Leaves, Roots',
  },
  {
    'Crop Name': 'Chicory',
    'Usage': 'Biochar Production, Animal Feed, Composting',
    'Wastage': 'Leaves, Roots',
  },
  {
    'Crop Name': 'Sugar Beet',
    'Usage': 'Bioenergy Production, Composting, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Peels',
  },
  {
    'Crop Name': 'Alfalfa',
    'Usage': 'Animal Feed, Bioenergy Production, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Sorrel',
    'Usage': 'Composting, Soil Fertility Enhancement, Animal Feed',
    'Wastage': 'Leaves',
  },
  {
    'Crop Name': 'Clover',
    'Usage': 'Animal Feed, Biochar Production, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Stems',
  },
  {
    'Crop Name': 'Mulberry',
    'Usage': 'Silkworm Feed, Composting, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Branches',
  },
  {
    'Crop Name': 'Sesame',
    'Usage': 'Composting, Biochar Production, Soil Amendment',
    'Wastage': 'Stalks, Pods',
  },
  {
    'Crop Name': 'Opium Poppy',
    'Usage': 'Bioenergy Production, Composting, Soil Fertility Enhancement',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Barley Grass',
    'Usage': 'Composting, Animal Feed, Biochar Production',
    'Wastage': 'Grass Clippings',
  },
  {
    'Crop Name': 'Ryegrass',
    'Usage': 'Composting, Animal Feed, Soil Fertility Enhancement',
    'Wastage': 'Grass Clippings',
  },
  {
    'Crop Name': 'Moringa',
    'Usage': 'Animal Feed, Biochar Production, Soil Fertility Enhancement',
    'Wastage': 'Leaves, Pods',
  },
  {
    'Crop Name': 'Spirulina (Algae)',
    'Usage': 'Bioenergy Production, Animal Feed, Soil Fertility Enhancement',
    'Wastage': 'Residue Biomass',
  },
  {
    'Crop Name': 'Seaweed',
    'Usage': 'Bioenergy Production, Fertilizer, Soil Fertility Enhancement',
    'Wastage': 'Residual Biomass',
  },
  {
    'Crop Name': 'Bamboo Shoots',
    'Usage': 'Composting, Bioenergy Production, Soil Amendment',
    'Wastage': 'Shoots, Leaves',
  },
  {
    'Crop Name': 'Durian',
    'Usage': 'Composting, Animal Feed, Soil Amendment',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Jackfruit',
    'Usage': 'Animal Feed, Bioenergy Production, Composting',
    'Wastage': 'Peels, Seeds',
  },
  {
    'Crop Name': 'Kenaf',
    'Usage': 'Paper Production, Bioenergy, Fodder',
    'Wastage': 'Stalks, Leaves',
  },
  {
    'Crop Name': 'Moringa',
    'Usage': 'Water Purification, Bioenergy, Animal Feed',
    'Wastage': 'Seed Husks, Pod Shells, Leaves',
  },

];


  Map<String, String>? searchResult;

  void performSearch(String query) {
    final String normalizedQuery = query.toLowerCase();

    // Use an empty map instead of null for `orElse`
    final Map<String, String> result = cropDatabase.firstWhere(
      (row) => row['Crop Name']?.toLowerCase().contains(normalizedQuery) ?? false,
      orElse: () => {}, // Return an empty map if no match is found
    );

    setState(() {
      searchResult = result.isEmpty ? null : result; // Set to null if the result is empty
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Suggestion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network("https://balchem.com/plant-nutrition/wp-content/uploads/sites/4/2021/02/Balchem-plant-nutrittion-field-crops.jpg"),
            const SizedBox(height: 50,),
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a crop',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: performSearch,
            ),
            const SizedBox(height: 20),
            if (searchResult != null)
              Expanded(
                child: ListView(
                  children: searchResult!.entries.map((entry) {
                    return ListTile(
                      title: Text(entry.key),
                      subtitle: Text(entry.value),
                    );
                  }).toList(),
                ),
              )
            else if (searchController.text.isNotEmpty)
              const Text(
                'No results found',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(CropSuggestionApp());
}
