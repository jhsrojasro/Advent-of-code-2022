/* eslint-disable prettier/prettier */
import * as fs from 'fs';
const input: number[] = fs.readFileSync("input_1.txt", "utf-8").trim().split('\n').map(Number)



input.map((x1) => {
    input.map((x2) => {
        if (x1 + x2 === 2020){
            console.log(x1 * x2);
        }
    });
})