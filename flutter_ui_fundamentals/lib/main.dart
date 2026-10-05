import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// IDENTITAS
// =====================================================

const String studentName = 'Sesilia Constantiana Tea';
const String studentId = '2415051112';
const String studentClass = 'PTI 5 C';

// =====================================================
// APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stage 16 - Debugging Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const DebuggingPage(),
    );
  }
}

// =====================================================
// HALAMAN UTAMA
// =====================================================

class DebuggingPage extends StatefulWidget {
  const DebuggingPage({super.key});

  @override
  State<DebuggingPage> createState() => _DebuggingPageState();
}

class _DebuggingPageState extends State<DebuggingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stage 16 - Debugging'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =================================================
            // IDENTITAS
            // =================================================

            const Text(
              studentName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'NIM: 2415051112',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const Text(
              'Kelas: PTI 5 C',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // JUDUL
            // =================================================

            const Text(
              'Debugging Challenge',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // KASUS A
            // =================================================

            buildSectionTitle(
              'Kasus A - RenderFlex Overflow',
            ),

            const SizedBox(height: 8),

            const Text(
              'Solusi menggunakan Expanded agar teks panjang '
              'menyesuaikan ruang yang tersedia.',
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      size: 30,
                    ),

                    const SizedBox(width: 8),

                    // FIX:
                    // Expanded mencegah teks keluar
                    // dari batas horizontal Row.
                    const Expanded(
                      child: Text(
                        '$studentId - $studentName - '
                        'teks sangat panjang yang digunakan '
                        'untuk menguji masalah RenderFlex overflow '
                        'pada Row.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // KASUS B
            // =================================================

            buildSectionTitle(
              'Kasus B - ListView dalam Column',
            ),

            const SizedBox(height: 8),

            const Text(
              'Solusi menggunakan Expanded agar ListView '
              'mendapatkan tinggi yang terbatas.',
            ),

            const SizedBox(height: 12),

            // Memberikan tinggi terbatas agar Expanded
            // dapat bekerja dengan benar.
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Daftar Course',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // FIX:
                  // Expanded memberikan batas tinggi
                  // kepada ListView.
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text(
                            'Pemrograman Mobile',
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text(
                            'Pemrograman Web',
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text(
                            'Basis Data',
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text(
                            'Jaringan Komputer',
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.school),
                          title: Text(
                            'Sistem Operasi',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // KASUS C
            // =================================================

            buildSectionTitle(
              'Kasus C - Keyboard Overflow',
            ),

            const SizedBox(height: 8),

            const Text(
              'Form dibungkus SingleChildScrollView agar '
              'tetap dapat diakses ketika keyboard muncul.',
            ),

            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'NIM',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.number,
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Komentar',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Form berhasil diproses',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Kirim',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // KASUS D
            // =================================================

            buildSectionTitle(
              'Kasus D - Navigasi Ganda',
            ),

            const SizedBox(height: 8),

            const Text(
              'Tombol dicegah melakukan push berulang '
              'ketika navigasi sedang berlangsung.',
            ),

            const SizedBox(height: 12),

            NavigationTestButton(),

            const SizedBox(height: 24),

            // =================================================
            // PENJELASAN
            // =================================================

            buildSectionTitle(
              'Kesimpulan Debugging',
            ),

            const SizedBox(height: 12),

            const Text(
              'A. Expanded digunakan agar teks panjang '
              'tidak menyebabkan RenderFlex overflow.\n\n'
              'B. Expanded memberikan batas tinggi kepada '
              'ListView di dalam Column.\n\n'
              'C. SingleChildScrollView membuat form dapat '
              'di-scroll ketika keyboard mengurangi ruang layar.\n\n'
              'D. Tombol navigasi dinonaktifkan sementara '
              'agar route tidak ter-push berkali-kali.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // WIDGET JUDUL SECTION
  // =====================================================

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// =====================================================
// KASUS D - NAVIGATION BUTTON
// =====================================================

class NavigationTestButton extends StatefulWidget {
  const NavigationTestButton({super.key});

  @override
  State<NavigationTestButton> createState() =>
      _NavigationTestButtonState();
}

class _NavigationTestButtonState
    extends State<NavigationTestButton> {
  bool isOpening = false;

  Future<void> openDetail() async {
    // Mencegah tombol ditekan berkali-kali.
    if (isOpening) {
      return;
    }

    setState(() {
      isOpening = true;
    });

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationDetailPage(),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      isOpening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton.icon(
        onPressed: isOpening ? null : openDetail,

        icon: const Icon(
          Icons.open_in_new,
        ),

        label: Text(
          isOpening
              ? 'Membuka Detail...'
              : 'Buka Detail',
        ),
      ),
    );
  }
}

// =====================================================
// HALAMAN DETAIL KASUS D
// =====================================================

class NavigationDetailPage extends StatelessWidget {
  const NavigationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Navigation Detail',
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: const [
              Icon(
                Icons.check_circle,
                size: 80,
              ),

              SizedBox(height: 20),

              Text(
                'Navigation berhasil dibuka',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 12),

              Text(
                'Tekan tombol Back untuk kembali.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}