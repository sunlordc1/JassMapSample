const fs = require('fs');
const path = require('path');

// List of folders containing .j files
const folderPaths = ['./1-Variables Library System Func', './2-Objective', './3-Skill', './4-Event', './5-Features', './6-Timers']; // Thay thế với đường dẫn thực tế của cậu
// Replace with your actual folder paths
const individualFiles = ['./GAME.j','./EXAMPLE.j']; // Replace with your actual individual file paths
// Output file path with .j extension
const outputPath = './combine.txt';



// Function to read and copy content from a folder
const readAndCopyFromFolder = (folderPath) => {
    const files = fs.readdirSync(folderPath);
    const txtFiles = files.filter(file => path.extname(file) === '.j');

    let allContent = '';
    txtFiles.forEach(file => {
        const filePath = path.join(folderPath, file);
        const content = fs.readFileSync(filePath, 'utf-8');
        allContent += `//--- Content from folder: ${folderPath}/${file} ---\n`; // Title for each file
        allContent += content + '\n\n'; // Add two new lines after each file
    });

    return allContent;
};

// Function to read content from individual files
const readAndCopyIndividualFiles = (files) => {
    let allContent = '';
    files.forEach(file => {
        try {
            const content = fs.readFileSync(file, 'utf-8');
            allContent += `//--- Content from individual file: ${file} ---\n`; // Title for each individual file
            allContent += content + '\n\n'; // Add two new lines after each file
        } catch (err) {
            console.error(`Error reading file ${file}:`, err);
        }
    });
    return allContent;
};

// Variable to store all content
let totalContent = '';

// Process each folder in order
folderPaths.forEach(folderPath => {
    try {
        const content = readAndCopyFromFolder(folderPath);
        totalContent += content; // Merge content from all folders
    } catch (err) {
        console.error(`Error reading folder ${folderPath}:`, err);
    }
});

// Write content from individual files last
const individualContent = readAndCopyIndividualFiles(individualFiles);
totalContent += individualContent; // Merge content from individual files at the end

// Write all content to the output file with .j extension
fs.writeFileSync(outputPath, totalContent);
console.log('Finished copying content to:', outputPath);