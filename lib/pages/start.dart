import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  var box = Hive.box('medication');

  final TextEditingController _name = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    List<String> categories = [
      'Pain Relievers',
      'Antibiotics',
      'Allergy Relief',
      'Cold and Flu Remedies',
      'Digestive Health',
      'Heart Health',
      'Mental Health',
      'Diabetes Management',
      'Skin Treatments',
      'Sleep Aid',
      'Vitamins and Supplements'
    ];

    List<Medication> all = [
      // Pain Relievers
      Medication(id: 1, name: 'Ibuprofen', active: false, cycle: 1, last: today, next: today, stock: 10, started: today, total: 20, category: categories[0], prescription: false, info: 'Pain relief for headaches and inflammation'),
      Medication(id: 2, name: 'Acetaminophen', active: false, cycle: 1, last: today, next: today, stock: 12, started: today, total: 20, category: categories[0], prescription: false, info: 'Relieves mild pain and reduces fever'),
      Medication(id: 3, name: 'Aspirin', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 30, category: categories[0], prescription: false, info: 'Pain and inflammation relief, also used for heart health'),
      Medication(id: 4, name: 'Naproxen', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 20, category: categories[0], prescription: false, info: 'Nonsteroidal anti-inflammatory drug for pain relief'),
      Medication(id: 5, name: 'Diclofenac', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 25, category: categories[0], prescription: false, info: 'Anti-inflammatory drug for arthritis pain relief'),

      // Antibiotics
      Medication(id: 6, name: 'Amoxicillin', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 30, category: categories[1], prescription: true, info: 'Antibiotic for bacterial infections'),
      Medication(id: 7, name: 'Ciprofloxacin', active: false, cycle: 1, last: today, next: today, stock: 8, started: today, total: 20, category: categories[1], prescription: true, info: 'Used to treat urinary tract infections'),
      Medication(id: 8, name: 'Clindamycin', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 30, category: categories[1], prescription: true, info: 'Antibiotic for treating skin and soft tissue infections'),
      Medication(id: 9, name: 'Doxycycline', active: false, cycle: 1, last: today, next: today, stock: 12, started: today, total: 20, category: categories[1], prescription: true, info: 'Used for treating respiratory and skin infections'),
      Medication(id: 10, name: 'Azithromycin', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 25, category: categories[1], prescription: true, info: 'Antibiotic for bacterial infections of the lungs and respiratory system'),

      // Allergy Relief
      Medication(id: 11, name: 'Cetirizine', active: false, cycle: 1, last: today, next: today, stock: 30, started: today, total: 30, category: categories[2], prescription: false, info: 'Antihistamine for allergy relief'),
      Medication(id: 12, name: 'Loratadine', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 30, category: categories[2], prescription: false, info: 'Relieves allergy symptoms like sneezing and runny nose'),
      Medication(id: 13, name: 'Fexofenadine', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 30, category: categories[2], prescription: false, info: 'Used for seasonal allergies and hay fever'),
      Medication(id: 14, name: 'Diphenhydramine', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 20, category: categories[2], prescription: false, info: 'Antihistamine for allergy relief and sleep aid'),
      Medication(id: 15, name: 'Chlorpheniramine', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 25, category: categories[2], prescription: false, info: 'Relieves symptoms of hay fever and other allergies'),

      // Cold and Flu Remedies
      Medication(id: 16, name: 'Pseudoephedrine', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 40, category: categories[3], prescription: false, info: 'Decongestant for nasal congestion'),
      Medication(id: 17, name: 'Oseltamivir', active: false, cycle: 1, last: today, next: today, stock: 5, started: today, total: 10, category: categories[3], prescription: true, info: 'Antiviral medication for flu treatment'),
      Medication(id: 18, name: 'Guaifenesin', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 30, category: categories[3], prescription: false, info: 'Expectorant for chest congestion'),
      Medication(id: 19, name: 'DayQuil', active: false, cycle: 1, last: today, next: today, stock: 12, started: today, total: 15, category: categories[3], prescription: false, info: 'Relieves symptoms of cold and flu'),
      Medication(id: 20, name: 'NyQuil', active: false, cycle: 1, last: today, next: today, stock: 8, started: today, total: 12, category: categories[3], prescription: false, info: 'Nighttime relief from cold and flu symptoms'),

      // Digestive Health
      Medication(id: 21, name: 'Loperamide', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 30, category: categories[4], prescription: false, info: 'Anti-diarrheal medication'),
      Medication(id: 22, name: 'Omeprazole', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 20, category: categories[4], prescription: false, info: 'Proton pump inhibitor for acid reflux'),
      Medication(id: 23, name: 'Pantoprazole', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 25, category: categories[4], prescription: false, info: 'For treating GERD and acid reflux'),
      Medication(id: 24, name: 'Simethicone', active: false, cycle: 1, last: today, next: today, stock: 30, started: today, total: 30, category: categories[4], prescription: false, info: 'Anti-gas medication'),
      Medication(id: 25, name: 'Probiotic Supplements', active: false, cycle: 1, last: today, next: today, stock: 50, started: today, total: 60, category: categories[4], prescription: false, info: 'Helps maintain healthy gut flora'),

      // Heart Health
      Medication(id: 26, name: 'Amlodipine', active: false, cycle: 1, last: today, next: today, stock: 22, started: today, total: 30, category: categories[5], prescription: true, info: 'Used to treat high blood pressure'),
      Medication(id: 27, name: 'Atorvastatin', active: false, cycle: 1, last: today, next: today, stock: 30, started: today, total: 30, category: categories[5], prescription: true, info: 'Statin for lowering cholesterol levels'),
      Medication(id: 28, name: 'Lisinopril', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 25, category: categories[5], prescription: true, info: 'ACE inhibitor for treating high blood pressure'),
      Medication(id: 29, name: 'Furosemide', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 25, category: categories[5], prescription: true, info: 'Used for treating heart failure and swelling'),
      Medication(id: 30, name: 'Ezetimibe', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 20, category: categories[5], prescription: true, info: 'Used to lower cholesterol levels'),

      // Mental Health
      Medication(id: 31, name: 'Sertraline', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 30, category: categories[6], prescription: true, info: 'Antidepressant for treating anxiety and depression'),
      Medication(id: 32, name: 'Alprazolam', active: false, cycle: 1, last: today, next: today, stock: 10, started: today, total: 20, category: categories[6], prescription: true, info: 'Benzodiazepine for anxiety relief'),
      Medication(id: 33, name: 'Escitalopram', active: false, cycle: 1, last: today, next: today, stock: 12, started: today, total: 25, category: categories[6], prescription: true, info: 'Selective serotonin reuptake inhibitor (SSRI) for anxiety and depression'),
      Medication(id: 34, name: 'Fluoxetine', active: false, cycle: 1, last: today, next: today, stock: 14, started: today, total: 20, category: categories[6], prescription: true, info: 'Used to treat depression, panic attacks, and OCD'),
      Medication(id: 35, name: 'Bupropion', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 30, category: categories[6], prescription: true, info: 'Used for treating depression and smoking cessation'),

      // Diabetes Management
      Medication(id: 36, name: 'Metformin', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 30, category: categories[7], prescription: true, info: 'Used to control blood sugar levels in type 2 diabetes'),
      Medication(id: 37, name: 'Insulin Glargine', active: false, cycle: 1, last: today, next: today, stock: 5, started: today, total: 10, category: categories[7], prescription: true, info: 'Long-acting insulin for managing diabetes'),
      Medication(id: 38, name: 'Glipizide', active: false, cycle: 1, last: today, next: today, stock: 12, started: today, total: 20, category: categories[7], prescription: true, info: 'Sulfonylurea medication used to treat type 2 diabetes'),
      Medication(id: 39, name: 'Sitagliptin', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 30, category: categories[7], prescription: true, info: 'DPP-4 inhibitor for controlling blood sugar in diabetes'),
      Medication(id: 40, name: 'Pioglitazone', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 25, category: categories[7], prescription: true, info: 'Used for managing type 2 diabetes by improving insulin sensitivity'),

      // Skin Treatments
      Medication(id: 41, name: 'Hydrocortisone', active: false, cycle: 1, last: today, next: today, stock: 30, started: today, total: 30, category: categories[8], prescription: false, info: 'Topical steroid for skin irritation and inflammation'),
      Medication(id: 42, name: 'Neosporin', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 30, category: categories[8], prescription: false, info: 'Antibiotic ointment for cuts, scrapes, and burns'),
      Medication(id: 43, name: 'Benzoyl Peroxide', active: false, cycle: 1, last: today, next: today, stock: 18, started: today, total: 25, category: categories[8], prescription: false, info: 'Treatment for acne and blemishes'),
      Medication(id: 44, name: 'Tretinoin', active: false, cycle: 1, last: today, next: today, stock: 20, started: today, total: 30, category: categories[8], prescription: true, info: 'Retinoid for acne treatment and reducing wrinkles'),
      Medication(id: 45, name: 'Aloe Vera Gel', active: false, cycle: 1, last: today, next: today, stock: 15, started: today, total: 20, category: categories[8], prescription: false, info: 'Soothing gel for skin burns and irritation'),

      // Sleep Aid
      Medication(id: 46, name: 'Melatonin', active: false, cycle: 1, last: today, next: today, stock: 50, started: today, total: 60, category: categories[9], prescription: false, info: 'Hormone supplement to help with sleep'),
      Medication(id: 47, name: 'Diphenhydramine', active: false, cycle: 1, last: today, next: today, stock: 30, started: today, total: 40, category: categories[9], prescription: false, info: 'Antihistamine used as a sleep aid'),
      Medication(id: 48, name: 'Doxylamine', active: false, cycle: 1, last: today, next: today, stock: 25, started: today, total: 30, category: categories[9], prescription: false, info: 'Sedating antihistamine for short-term insomnia'),
      Medication(id: 49, name: 'Zolpidem', active: false, cycle: 1, last: today, next: today, stock: 10, started: today, total: 20, category: categories[9], prescription: true, info: 'Prescription medication for insomnia'),
      Medication(id: 50, name: 'Valerian Root', active: false, cycle: 1, last: today, next: today, stock: 40, started: today, total: 50, category: categories[9], prescription: false, info: 'Herbal supplement used to improve sleep'),

      // Vitamins and Supplements
      Medication(id: 51, name: 'Vitamin D3', active: false, cycle: 1, last: today, next: today, stock: 60, started: today, total: 60, category: categories[10], prescription: false, info: 'Supplement for bone health and immunity'),
      Medication(id: 52, name: 'Vitamin C', active: false, cycle: 1, last: today, next: today, stock: 40, started: today, total: 50, category: categories[10], prescription: false, info: 'Boosts immune system and promotes skin health'),
      Medication(id: 53, name: 'Multivitamins', active: false, cycle: 1, last: today, next: today, stock: 35, started: today, total: 50, category: categories[10], prescription: false, info: 'General health support and nutrient supplement'),
      Medication(id: 54, name: 'Omega-3 Fish Oil', active: false, cycle: 1, last: today, next: today, stock: 45, started: today, total: 60, category: categories[10], prescription: false, info: 'Supports heart and brain health'),
      Medication(id: 55, name: 'Probiotic Supplements', active: false, cycle: 1, last: today, next: today, stock: 50, started: today, total: 60, category: categories[10], prescription: false, info: 'Helps maintain healthy gut flora'),

    ];
    
    List<bool> running = [false, false, false, false, false];
    List<bool> completed = [false, false, false, false, false];
    List<double> result = [0,0,0,0,0];

    return Scaffold(
        body: Center(
      child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        labelText: 'Hi there, what\'s your name?'),
                  )),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blue[100], 
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(12.0))
                        ),
                      child: TextButton(
                          onPressed: () {
                            String input = _name.text;
                            setState(() {
                              if (input.isNotEmpty) {
                                box.put(2, input);
                                List<Medication> m = [];
                                box.put(0, m);
                                box.put(1, 'ready');
                                box.put(3, false);
                                box.put(8, completed);
                                box.put(9, running);
                                box.put(10, result);
                                box.put(11, true);
                                box.put(12, DateTime.now());
                              } else {
                                box.put(1, 'not-ready');
                              }
                            });
                          },
                          child: const Text('Confirm', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              const Text(
                '(Enter your name and confirm)',
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(
                height: 40,
              ),
              (box.get(1) == 'ready')
                  ? Row(
                      children: [
                        Flexible(child:
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue[100], 
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(12.0))
                            ),
                            child: TextButton(
                              onPressed: () {
                                box.put(3, false);
                                box.put(4, true);
                                box.put(5, all);
                                box.put(6, false);
                                box.put(7,-1);
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const Navigation(),
                                ),);
                              }
                              , child: const Text('Start fresh', style: TextStyle(color: Colors.black))
                            )
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Flexible(child:
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue[100], 
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(12.0))
                          ),
                          child: TextButton(
                            onPressed: () {
                              

                              Duration w = const Duration(days: 7);

                              List<DateTime> past = [];
                              List<DateTime> future = [];

                              for(int i = 0; i < 400; i++) {
                                past.add(today.subtract(Duration(days: i)));
                              }

                              for(int i = 0; i < 100; i++) {
                                future.add(today.add(Duration(days: i)));
                              }


                              /*
                              List<Medication> medication = [

                                Medication(id: 0, name: 'Vitamin A', active: true, cycle: 7, last: past[20], next: past[13], stock: 9, started: past[30], total: 1),
                                Medication(id: 1, name: 'Vitamin B', active: false, cycle: 7, last: past[18], next: past[11], stock: 0, started: past[30], total: 2),
                                Medication(id: 2, name: 'Vitamin C', active: true, cycle: 7, last: past[17], next: past[10], stock: 4, started: past[30], total: 3),
                                Medication(id: 3, name: 'Vitamin D', active: true, cycle: 7, last: past[10], next: past[3], stock: 24, started: past[30], total: 4),
                                Medication(id: 4, name: 'Vitamin E', active: false, cycle: 7, last: past[8], next: past[1], stock: 2, started: past[30], total: 3),
                                Medication(id: 5, name: 'Vitamin F', active: true, cycle: 7, last: past[7], next: past[0], stock: 14, started: past[30], total: 2),
                                
                                Medication(id: 6, name: 'Vitamin G', active: true, cycle: 7, last: past[7], next: past[0], stock: 4, started: past[30], total: 4),
                                Medication(id: 7, name: 'Vitamin H', active: true, cycle: 7, last: past[7], next: past[0], stock: 18, started: past[30], total: 5),
                                Medication(id: 8, name: 'Vitamin I', active: true, cycle: 7, last: past[7], next: past[0], stock: 17, started: past[30], total: 5),
                                Medication(id: 9, name: 'Vitamin J', active: false, cycle: 7, last: past[7], next: past[0], stock: 19, started: past[30], total: 4),
                                Medication(id: 10, name: 'Vitamin K', active: true, cycle: 7, last: past[7], next: past[0], stock: 6, started: past[30], total: 3),
                                Medication(id: 11, name: 'Vitamin L', active: false, cycle: 7, last: past[7], next: past[0], stock: 11, started: past[30], total: 3),

                                Medication(id: 12, name: 'Vitamin M', active: false, cycle: 7, last: past[6], next: future[1], stock: 34, started: past[30], total: 4),
                                Medication(id: 13, name: 'Vitamin N', active: true, cycle: 7, last: past[4], next: future[3], stock: 7, started: past[30], total: 4),
                                Medication(id: 14, name: 'Vitamin O', active: true, cycle: 7, last: past[3], next: future[4], stock: 12, started: past[30], total: 4),
                                Medication(id: 15, name: 'Vitamin P', active: true, cycle: 7, last: past[2], next: future[5], stock: 3, started: past[30], total: 5),
                                Medication(id: 16, name: 'Vitamin Q', active: false, cycle: 7, last: past[1], next: future[6], stock: 0, started: past[30], total: 6),

                              ];
                              */

                              List<Medication> medication = [
                                Medication(id: 0, name: 'Vitamin A 5000 IU', active: true, cycle: 7, last: past[2], next: future[5], stock: 12, started: past[30], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 1, name: 'Vitamin B 100mg', active: false, cycle: 7, last: past[3], next: future[4], stock: 7, started: past[25], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 2, name: 'Vitamin C 500mg', active: true, cycle: 7, last: past[7], next: future[0], stock: 15, started: past[40], total: 5, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 0, name: 'Vitamin D 1000 IU', active: true, cycle: 7, last: past[8], next: past[1], stock: 12, started: past[30], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 3, name: 'Paracetamol 500mg', active: true, cycle: 1, last: past[1], next: today, stock: 24, started: past[10], total: 6, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 4, name: 'Ibuprofen 400mg', active: true, cycle: 2, last: past[5], next: past[3], stock: 12, started: past[20], total: 8, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 5, name: 'Iron 65mg', active: true, cycle: 14, last: past[11], next: future[3], stock: 17, started: past[50], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 6, name: 'Calcium 500mg', active: true, cycle: 7, last: past[3], next: future[4], stock: 17, started: past[30], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 7, name: 'Zinc 50mg', active: false, cycle: 7, last: past[8], next: past[1], stock: 13, started: past[20], total: 2, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 8, name: 'Magnesium 400mg', active: true, cycle: 7, last: past[1], next: future[6], stock: 25, started: past[45], total: 5, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 9, name: 'Omega-3 1000mg', active: true, cycle: 1, last: today, next: future[1], stock: 26, started: past[100], total: 74, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 10, name: 'Probiotic', active: true, cycle: 30, last: past[25], next: future[5], stock: 8, started: past[120], total: 3, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 11, name: 'Aspirin 81mg', active: false, cycle: 1, last: past[1], next: today, stock: 32, started: past[200], total: 173, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 12, name: 'Metformin 500mg', active: true, cycle: 1, last: past[0], next: future[0], stock: 9, started: past[180], total: 132, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 13, name: 'Atorvastatin 20mg', active: true, cycle: 1, last: past[1], next: today, stock: 16, started: past[365], total: 301, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 14, name: 'Folic Acid 5mg', active: true, cycle: 7, last: past[6], next: future[1], stock: 12, started: past[60], total: 8, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 15, name: 'Vitamin D 1000 IU', active: true, cycle: 7, last: past[7], next: today, stock: 1, started: past[90], total: 11, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 16, name: 'Lisinopril 10mg', active: true, cycle: 1, last: past[1], next: today, stock: 11, started: past[120], total: 89, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 17, name: 'Albuterol 90mcg', active: false, cycle: 1, last: past[1], next: today, stock: 16, started: past[180], total: 113, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 18, name: 'Cetirizine 10mg', active: true, cycle: 1, last: past[3], next: past[2], stock: 23, started: past[50], total: 42, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 19, name: 'Prednisone 10mg', active: false, cycle: 1, last: past[1], next: today, stock: 29, started: past[30], total: 21, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 20, name: 'Amlodipine 5mg', active: false, cycle: 1, last: past[2], next: past[1], stock: 14, started: past[90], total: 75, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 21, name: 'Clopidogrel 75mg', active: true, cycle: 1, last: past[1], next: today, stock: -10, started: past[120], total: 108, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 22, name: 'Warfarin 5mg', active: true, cycle: 1, last: today, next: future[0], stock: 48, started: past[200], total: 186, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 23, name: 'Hydrochlorothiazide 25mg', active: true, cycle: 1, last: past[1], next: future[0], stock: 30, started: past[150], total: 133, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 25, name: 'Omeprazole 20mg', active: false, cycle: 1, last: today, next: future[0], stock: 19, started: past[180], total: 144, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 24, name: 'Levothyroxine 50mcg', active: true, cycle: 1, last: past[5], next: past[4], stock: 43, started: past[300], total: 225, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 26, name: 'Citalopram 20mg', active: true, cycle: 2, last: past[1], next: future[1], stock: 6, started: past[90], total: 39, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 27, name: 'Fluoxetine 20mg', active: true, cycle: 2, last: past[2], next: future[0], stock: 32, started: past[200], total: 89, category: 'any', prescription: false, info: '--- Medication Info ---'),
                                Medication(id: 28, name: 'Prolia 60mg', active: true, cycle: 180, last: past[100], next: future[80], stock: 3, started: past[360], total: 2, category: 'any', prescription: false, info: '--- Medication Info ---'),
                              ];

                              setState(() {
                                box.put(0, medication);
                                box.put(3, false);
                                box.put(4, true);
                                box.put(5, all);
                                box.put(6, false);
                                box.put(7,medication.length-1);
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const Navigation(),
                              ),);
                            }
                            , child: const Text('Test with sample data', style: TextStyle(color: Colors.black), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,)
                          )
                        ),)
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          )),
    ));
  }
}
