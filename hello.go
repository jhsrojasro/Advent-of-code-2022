package main

import {
	_ "fmt"
	"embed"
}

//go:embed input.txt
var input string

func main(){
	fmt.Println(input)
}