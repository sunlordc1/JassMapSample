const fs = require('fs');
const path = require('path');

// Danh sách các thư mục chứa các file .txt
const folderPaths = ['./1-Variables Library System Func', './2-Objective', './3-Skill', './4-Event', './5-Features', './6-Timers']; // Thay thế với đường dẫn thực tế của cậu
// Danh sách các thư mục chứa các file .txt
const individualFiles = ['./GAME.j']; // Thay thế với đường dẫn thực tế của các file lẻ
// Đường dẫn file output
const outputPath = './combine.j';

// Hàm để đọc và chép nội dung từ một thư mục
const readAndCopyFromFolder = (folderPath) => {
    const files = fs.readdirSync(folderPath);
    const txtFiles = files.filter(file => path.extname(file) === '.j');

    let allContent = '';
    txtFiles.forEach(file => {
        const filePath = path.join(folderPath, file);
        const content = fs.readFileSync(filePath, 'utf-8');
        allContent += `//--- Nội dung từ thư mục: ${folderPath}/${file} ---\n`; // Tiêu đề cho mỗi file
        allContent += content + '\n\n'; // Thêm hai lần xuống dòng sau mỗi file
    });

    return allContent;
};

// Hàm để đọc nội dung từ các file lẻ
const readAndCopyIndividualFiles = (files) => {
    let allContent = '';
    files.forEach(file => {
        try {
            const content = fs.readFileSync(file, 'utf-8');
            allContent += `//--- Nội dung từ file lẻ: ${file} ---\n`; // Tiêu đề cho mỗi file lẻ
            allContent += content + '\n\n'; // Thêm hai lần xuống dòng sau mỗi file
        } catch (err) {
            console.error(`Lỗi khi đọc file ${file}:`, err);
        }
    });
    return allContent;
};

// Biến để lưu tất cả nội dung
let totalContent = '';

// Xử lý từng thư mục theo thứ tự
folderPaths.forEach(folderPath => {
    try {
        const content = readAndCopyFromFolder(folderPath);
        totalContent += content; // Gộp nội dung từ tất cả các thư mục
    } catch (err) {
        console.error(`Lỗi khi đọc thư mục ${folderPath}:`, err);
    }
});

// Ghi nội dung từ các file lẻ sau cùng
const individualContent = readAndCopyIndividualFiles(individualFiles);
totalContent += individualContent; // Gộp nội dung từ các file lẻ vào cuối

// Ghi tất cả nội dung vào file output
fs.writeFileSync(outputPath, totalContent);
console.log('Hoàn thành chép nội dung vào:', outputPath);