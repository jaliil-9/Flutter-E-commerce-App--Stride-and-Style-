const admin = require('firebase-admin');

// Initialize Firebase Admin SDK
const serviceAccount = require('./stride-and-style-firebase-adminsdk-msaya-719af628f5.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

const firestore = admin.firestore();

async function removeDuplicateDocumentsByTitle(collectionPath) {
    try {
    const collectionRef = firestore.collection(collectionPath);
    const snapshot = await collectionRef.get();

    console.log(`Fetched ${snapshot.docs.length} documents.`);

    const uniqueTitles = new Map(); // Store unique titles and their document IDs
    const duplicateDocIds = []; // Track duplicate document IDs

    snapshot.docs.forEach((doc) => {
        const data = doc.data();
        const title = data.title;

        if (title) {
        if (uniqueTitles.has(title)) {
          duplicateDocIds.push(doc.id); // Mark as duplicate
        } else {
          uniqueTitles.set(title, doc.id); // Store first occurrence
        }
        }
    });

    console.log(`Found ${duplicateDocIds.length} duplicate documents.`);

    // Delete duplicate documents
    for (const docId of duplicateDocIds) {
        await collectionRef.doc(docId).delete();
        console.log(`Deleted document with ID: ${docId}`);
    }

    console.log('Duplicate removal complete.');
    } catch (error) {
    console.error('Error removing duplicates:', error);
    }
}

// Run the function
removeDuplicateDocumentsByTitle('Products');