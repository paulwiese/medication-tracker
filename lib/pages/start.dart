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
  
      // **Pain Relievers**
      Medication(id: 1, name: 'Ibuprofen', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[0], prescription: false, info: 'Common NSAID used for pain relief, inflammation, and fever. \n\nCan irritate the stomach, especially if taken without food. Long-term use increases the risk of ulcers or gastrointestinal bleeding.'),
      Medication(id: 2, name: 'Acetaminophen', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[0], prescription: false, info: 'Widely used for pain and fever relief. \n\nDoes not irritate the stomach, making it gentler on the digestive system compared to NSAIDs.'),
      Medication(id: 3, name: 'Diclofenac', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[0], prescription: true, info: 'Prescription NSAID often used for arthritis and joint pain. \n\nMay cause stomach irritation, nausea, or ulcers, especially when used for extended periods or in high doses. Best taken with food to reduce stomach upset.'),
      Medication(id: 4, name: 'Aspirin', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[0], prescription: false, info: 'NSAID for pain, fever, and inflammation relief. \n\nCan cause stomach irritation and increase the risk of ulcers, bleeding, and gastrointestinal issues, especially in long-term or high-dose use.'),
      Medication(id: 5, name: 'Celecoxib', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[0], prescription: true, info: 'Prescription NSAID used to treat pain, especially for arthritis and other inflammatory conditions. \n\nLower risk of stomach irritation compared to traditional NSAIDs like ibuprofen or aspirin, but still can cause gastrointestinal issues in some people.'),
      Medication(id: 6, name: 'Naproxen', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[0], prescription: false, info: 'NSAID used for pain relief and inflammation. \n\nCan cause stomach irritation, especially if taken without food. Long-term use may increase the risk of ulcers or gastrointestinal bleeding.'),

      // **Antibiotics**
      Medication(id: 7, name: 'Amoxicillin', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[1], prescription: true, info: 'Used to treat bacterial infections. Not suitable for individuals allergic to penicillin.'),
      Medication(id: 8, name: 'Ciprofloxacin', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[1], prescription: true, info: 'Antibiotic for treating various bacterial infections. Avoid taking with dairy products.'),
      Medication(id: 9, name: 'Doxycycline', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[1], prescription: true, info: 'Antibiotic for bacterial infections. Avoid exposure to sunlight as it can cause skin sensitivity.'),
      Medication(id: 10, name: 'Azithromycin', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[1], prescription: true, info: 'Antibiotic for treating respiratory infections. Should be used cautiously in people with liver disease.'),
      Medication(id: 11, name: 'Clindamycin', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[1], prescription: true, info: 'Used to treat bacterial infections like skin and respiratory infections. Should not be used for viral infections.'),
      Medication(id: 12, name: 'Metronidazole', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[1], prescription: true, info: 'Antibiotic for infections caused by anaerobic bacteria. Avoid alcohol while taking it due to possible severe interactions.'),
      
      // **Allergy Relief**
      Medication(id: 13, name: 'Cetirizine', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[2], prescription: false, info: 'Non-drowsy antihistamine for allergy relief. Suitable for daytime use.'),
      Medication(id: 14, name: 'Loratadine', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[2], prescription: false, info: 'Relieves allergy symptoms like sneezing and runny nose. Rarely causes drowsiness.'),
      Medication(id: 15, name: 'Diphenhydramine', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[2], prescription: false, info: 'Common antihistamine used for allergy relief. Can cause drowsiness; use caution while driving.'),
      Medication(id: 16, name: 'Fexofenadine', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[2], prescription: false, info: 'Non-sedating antihistamine, ideal for daytime use. Suitable for seasonal allergies and hay fever.'),
      Medication(id: 17, name: 'Chlorpheniramine', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[2], prescription: false, info: 'Used to relieve symptoms of hay fever and other allergies. Can cause drowsiness.'),
      Medication(id: 18, name: 'Levocetirizine', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[2], prescription: false, info: 'Effective antihistamine for allergy relief with fewer side effects compared to cetirizine.'),
      
      // **Cold and Flu Remedies**
      Medication(id: 19, name: 'Pseudoephedrine', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[3], prescription: false, info: 'Decongestant for nasal congestion. Not suitable for individuals with high blood pressure or heart disease.'),
      Medication(id: 20, name: 'Oseltamivir', active: true, cycle: 1, last: today, next: today, stock: 5, started: today, total: 0, category: categories[3], prescription: true, info: 'Antiviral medication for flu treatment. Best if taken within 48 hours of flu symptoms.'),
      Medication(id: 21, name: 'Guaifenesin', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[3], prescription: false, info: 'Expectorant for chest congestion. Helps loosen mucus for easier coughing.'),
      Medication(id: 22, name: 'DayQuil', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[3], prescription: false, info: 'Provides relief from cold and flu symptoms. Contains acetaminophen, so avoid exceeding the recommended dose.'),
      Medication(id: 23, name: 'NyQuil', active: true, cycle: 1, last: today, next: today, stock: 8, started: today, total: 0, category: categories[3], prescription: false, info: 'Nighttime relief from cold and flu symptoms. Contains alcohol and can cause drowsiness.'),
      Medication(id: 24, name: 'Zinc Lozenges', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[3], prescription: false, info: 'May help reduce the duration of a cold. Do not exceed the recommended daily dose to avoid nausea.'),
      
      // **Digestive Health**
      Medication(id: 25, name: 'Loperamide', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[4], prescription: false, info: 'Used to treat diarrhea. Not suitable for individuals with certain bacterial infections (e.g., C. difficile).'),
      Medication(id: 26, name: 'Bismuth Subsalicylate', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[4], prescription: false, info: 'Helps treat upset stomach, nausea, and diarrhea. May cause stool to turn black, which is harmless.'),
      Medication(id: 27, name: 'Docusate Sodium', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[4], prescription: false, info: 'Stool softener used to relieve constipation. Drink plenty of fluids while taking it.'),
      Medication(id: 28, name: 'Lactulose', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[4], prescription: true, info: 'Used to treat constipation and liver disease-related complications. Not suitable for individuals with lactose intolerance.'),
      Medication(id: 29, name: 'Metoclopramide', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[4], prescription: true, info: 'Used to treat nausea and vomiting. Can cause drowsiness or dizziness.'),
      Medication(id: 30, name: 'Omeprazole', active: true, cycle: 1, last: today, next: today, stock: 22, started: today, total: 0, category: categories[4], prescription: false, info: 'Proton pump inhibitor used to treat heartburn and acid reflux. Not suitable for long-term use without medical supervision.'),
      
      // **Heart Health**
      Medication(id: 31, name: 'Amlodipine', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[5], prescription: true, info: 'Calcium channel blocker used to treat high blood pressure. Can cause swelling of the ankles and feet.'),
      Medication(id: 32, name: 'Atorvastatin', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[5], prescription: true, info: 'Statin used to lower cholesterol levels. Monitor liver function while on this medication.'),
      Medication(id: 33, name: 'Clopidogrel', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[5], prescription: true, info: 'Blood thinner used to reduce the risk of heart attack or stroke. Avoid taking with NSAIDs.'),
      Medication(id: 34, name: 'Losartan', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[5], prescription: true, info: 'Angiotensin II receptor blocker used to treat high blood pressure and heart failure.'),
      Medication(id: 35, name: 'Metoprolol', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[5], prescription: true, info: 'Beta blocker used to treat high blood pressure and heart issues. Can cause dizziness or fatigue.'),
      Medication(id: 36, name: 'Ezetimibe', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[5], prescription: true, info: 'Used to lower cholesterol by reducing absorption. Often used alongside statins.'),
      
      // **Mental Health**
      Medication(id: 37, name: 'Fluoxetine', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[6], prescription: true, info: 'Selective serotonin reuptake inhibitor (SSRI) used to treat depression and anxiety.'),
      Medication(id: 38, name: 'Sertraline', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[6], prescription: true, info: 'SSRI used for depression and anxiety. May take 4-6 weeks to see full effects.'),
      Medication(id: 39, name: 'Diazepam', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[6], prescription: true, info: 'Benzodiazepine used for anxiety and muscle relaxation. Can be habit-forming.'),
      Medication(id: 40, name: 'Bupropion', active: true, cycle: 1, last: today, next: today, stock: 8, started: today, total: 0, category: categories[6], prescription: true, info: 'Used for depression and smoking cessation. Can increase the risk of seizures in certain individuals.'),
      Medication(id: 41, name: 'Mirtazapine', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[6], prescription: true, info: 'Antidepressant that can also help with sleep and appetite. May cause drowsiness or weight gain.'),
      Medication(id: 42, name: 'Trazodone', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[6], prescription: true, info: 'Used to treat depression and insomnia. May cause drowsiness and dizziness.'),
      
      // **Diabetes Management**
      Medication(id: 43, name: 'Metformin', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[7], prescription: true, info: 'First-line medication for type 2 diabetes. Can cause stomach upset or diarrhea.'),
      Medication(id: 44, name: 'Insulin Glargine', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[7], prescription: true, info: 'Long-acting insulin used to control blood sugar in diabetes.'),
      Medication(id: 45, name: 'Glibenclamide', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[7], prescription: true, info: 'Sulfonylurea used to treat type 2 diabetes. Can cause low blood sugar levels.'),
      Medication(id: 46, name: 'Sitagliptin', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[7], prescription: true, info: 'DPP-4 inhibitor used to control blood sugar. Can cause upper respiratory infections.'),
      Medication(id: 47, name: 'Glimepiride', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[7], prescription: true, info: 'Sulfonylurea used to treat type 2 diabetes. Increases the risk of low blood sugar.'),
      Medication(id: 48, name: 'Canagliflozin', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[7], prescription: true, info: 'SGLT-2 inhibitor used for blood sugar control in diabetes. Can increase the risk of urinary tract infections.'),
      
      // **Skin Treatments**
      Medication(id: 49, name: 'Hydrocortisone', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[8], prescription: false, info: 'Topical steroid used to relieve itching, inflammation, and rashes. Avoid overuse to prevent skin thinning.'),
      Medication(id: 50, name: 'Benzoyl Peroxide', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[8], prescription: false, info: 'Topical treatment for acne. Can cause dryness and irritation, so use with caution.'),
      Medication(id: 51, name: 'Salicylic Acid', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[8], prescription: false, info: 'Used for acne treatment and exfoliation. Avoid excessive use as it can dry out the skin.'),
      Medication(id: 52, name: 'Clindamycin Gel', active: true, cycle: 1, last: today, next: today, stock: 10, started: today, total: 0, category: categories[8], prescription: true, info: 'Topical antibiotic used for acne treatment. Avoid using with other acne treatments unless recommended by a doctor.'),
      Medication(id: 53, name: 'Calamine Lotion', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[8], prescription: false, info: 'Used for soothing itching and irritation caused by poison ivy, insect bites, and other skin conditions.'),
      Medication(id: 54, name: 'Retinoid (Tretinoin)', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[8], prescription: true, info: 'Topical retinoid used for acne and reducing signs of aging. Can cause dryness and peeling.'),
      Medication(id: 55, name: 'Aloe Vera Gel', active: true, cycle: 1, last: today, next: today, stock: 22, started: today, total: 0, category: categories[8], prescription: false, info: 'Used to soothe sunburns and skin irritations. Can be used daily to moisturize the skin.'),
      
      // **Sleep Aid**
      Medication(id: 56, name: 'Melatonin', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[9], prescription: false, info: 'Natural hormone that helps regulate sleep-wake cycles. Safe for short-term use but may cause drowsiness the next day.'),
      Medication(id: 57, name: 'Diphenhydramine', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[9], prescription: false, info: 'Antihistamine with sedative properties, commonly used as a sleep aid. May cause dry mouth and drowsiness the next day.'),
      Medication(id: 58, name: 'Zolpidem', active: true, cycle: 1, last: today, next: today, stock: 15, started: today, total: 0, category: categories[9], prescription: true, info: 'Prescribed sedative used to treat insomnia. Can cause drowsiness the next day, and should only be taken when you can get 7-8 hours of sleep.'),
      Medication(id: 59, name: 'Eszopiclone', active: true, cycle: 1, last: today, next: today, stock: 20, started: today, total: 0, category: categories[9], prescription: true, info: 'Used for short-term treatment of insomnia. May cause a metallic taste and can impair memory if not used properly.'),
      Medication(id: 60, name: 'Valerian Root', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[9], prescription: false, info: 'Herbal supplement used for anxiety and sleep. Mild sedative properties, but can cause drowsiness the next day.'),
      Medication(id: 61, name: 'Trazodone', active: true, cycle: 1, last: today, next: today, stock: 12, started: today, total: 0, category: categories[9], prescription: true, info: 'An antidepressant also used off-label for sleep. It can cause drowsiness and is best taken before bed.'),
      
      // **Vitamins and Supplements**
      Medication(id: 62, name: 'Vitamin D3', active: true, cycle: 1, last: today, next: today, stock: 50, started: today, total: 0, category: categories[10], prescription: false, info: 'Vitamin D supplement that supports bone health. Ideal for individuals with limited sun exposure.'),
      Medication(id: 63, name: 'Vitamin B12', active: true, cycle: 1, last: today, next: today, stock: 40, started: today, total: 0, category: categories[10], prescription: false, info: 'Supports energy production and nerve function. Commonly taken by individuals with vitamin B12 deficiencies or vegans.'),
      Medication(id: 64, name: 'Iron Supplements', active: true, cycle: 1, last: today, next: today, stock: 30, started: today, total: 0, category: categories[10], prescription: false, info: 'Used to treat iron-deficiency anemia. Can cause stomach upset or constipation; take with food if needed.'),
      Medication(id: 65, name: 'Folic Acid', active: true, cycle: 1, last: today, next: today, stock: 25, started: today, total: 0, category: categories[10], prescription: false, info: 'Vitamin B9 supplement commonly used during pregnancy or to prevent neural tube defects.'),
      Medication(id: 66, name: 'Magnesium', active: true, cycle: 1, last: today, next: today, stock: 18, started: today, total: 0, category: categories[10], prescription: false, info: 'Helps with muscle relaxation and sleep. Often used for leg cramps and overall muscle health.'),
      Medication(id: 67, name: 'Probiotic Supplement', active: true, cycle: 1, last: today, next: today, stock: 22, started: today, total: 0, category: categories[10], prescription: false, info: 'Supports gut health by replenishing beneficial bacteria. Can help with digestive issues and immune function.'),
];
    
    List<bool> running = [false, false, false, false, false, false, false, false];
    List<bool> completed = [false, false, false, false, false, false, false, false];
    List<double> result = [0,0,0,0,0,0,0,0];

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
                        /*
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
                        ),)*/
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
