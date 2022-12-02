/* eslint-disable prettier/prettier */
// eslint-disable-next-line prettier/prettier
import * as fs from 'fs';
// eslint-disable-next-line prettier/prettier
const input: number[] = fs.readFileSync("input_1.txt", "utf-8").trim().split('\n').map(Number)



input.map((x1) => {
    input.map((x2) => {
        input.map(((x3) => {
            if (x1 + x2 + x3 === 2020){
                console.log(x1 * x2 * x3);
            }
        }));
    });
})