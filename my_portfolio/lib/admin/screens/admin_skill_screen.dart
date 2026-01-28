// import 'package:flutter/material.dart';
// import '../../data/data_source/skill_db.dart';
// import '../../data/models/skill_model.dart';

// class AdminSkillScreen extends StatefulWidget {
//   const AdminSkillScreen({super.key});

//   @override
//   State<AdminSkillScreen> createState() => _AdminSkillScreenState();
// }

// class _AdminSkillScreenState extends State<AdminSkillScreen> {
//   final SkillDB _skillDB = SkillDB();
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameCtrl = TextEditingController();
//   final TextEditingController percentCtrl = TextEditingController();

//   String category = 'Mobile';
//   int? editingId;

//   List<SkillModel> skills = [];

//   @override
//   void initState() {
//     super.initState();
//     loadSkills();
//   }

//   Future<void> loadSkills() async {
//     final data = await _skillDB.getSkills();
//     setState(() => skills = data);
//   }

//   void saveSkill() async {
//     if (!_formKey.currentState!.validate()) return;

//     final skill = SkillModel(
//       id: editingId,
//       name: nameCtrl.text.trim(),
//       category: category,
//       percentage: int.parse(percentCtrl.text),
//     );

//     if (editingId == null) {
//       await _skillDB.insertSkill(skill);
//     } else {
//       await _skillDB.updateSkill(skill);
//     }

//     clearForm();
//     loadSkills();
//   }

//   void editSkill(SkillModel skill) {
//     setState(() {
//       editingId = skill.id;
//       nameCtrl.text = skill.name;
//       percentCtrl.text = skill.percentage.toString();
//       category = skill.category;
//     });
//   }

//   void deleteSkill(int id) async {
//     await _skillDB.deleteSkill(id);
//     loadSkills();
//   }

//   void clearForm() {
//     editingId = null;
//     nameCtrl.clear();
//     percentCtrl.clear();
//     category = 'Mobile';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Admin → Skills")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: nameCtrl,
//                     decoration: const InputDecoration(labelText: "Skill Name"),
//                     validator: (v) => v!.isEmpty ? "Enter skill" : null,
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField(
//                     value: category,
//                     items:
//                         ['Mobile', 'Backend', 'Tools']
//                             .map(
//                               (e) => DropdownMenuItem(value: e, child: Text(e)),
//                             )
//                             .toList(),
//                     onChanged: (v) => setState(() => category = v!),
//                     decoration: const InputDecoration(labelText: "Category"),
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: percentCtrl,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: "Percentage"),
//                     validator: (v) => v!.isEmpty ? "Enter percentage" : null,
//                   ),
//                   const SizedBox(height: 12),
//                   ElevatedButton(
//                     onPressed: saveSkill,
//                     child: Text(
//                       editingId == null ? "Add Skill" : "Update Skill",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 30),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: skills.length,
//                 itemBuilder: (_, i) {
//                   final s = skills[i];
//                   return ListTile(
//                     title: Text(s.name),
//                     subtitle: Text("${s.category} • ${s.percentage}%"),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => editSkill(s),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () => deleteSkill(s.id!),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
