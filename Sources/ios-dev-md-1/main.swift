// Kristaps Naglis - 4. variants


// TO-DO
// 1) Add ability to write birthday date in normal format when declaring new employee (probably through helper function)

// Bugs
// ? 1) Task 3 - last added key in dictionary gets randomly shuffled around when printing

import Foundation

struct Person {

    enum sexType: String {
        case male = "male"
        case female = "female"
    }

    enum qualificationType: String {
        case intern = "intern"
        case juniorSpecialist = "junior specialist"
        case specialist = "specialist"
        case seniorSpecialist = "senior specialist"
        case projectManeger = "project maneger"
        case departmentManeger = "department maneger"
        case companyManeger = "company maneger"
    }

    var firstName: String
    var lastName: String
    let birthDay: Date
    var sex: sexType
    var qualification: qualificationType
    var salary: Double
    var department: String
    var longTermEmployee: Bool
}

let employee1 = Person(firstName: "Slappy", lastName: "Spunks", birthDay: Date(timeIntervalSince1970:734627222), sex: .male, qualification: .intern, salary: 1500.00, department: "Web", longTermEmployee: false)
let employee2 = Person(firstName: "Jizzy", lastName: "Stroker", birthDay: Date(timeIntervalSince1970:701784845), sex: .female, qualification: .departmentManeger, salary: 2000.00, department: "Back-End", longTermEmployee: true)
let employee3 = Person(firstName: "Dong", lastName: "Swellens", birthDay: Date(timeIntervalSince1970:768571624), sex: .male, qualification: .juniorSpecialist, salary: 2500.00, department: "Android", longTermEmployee: false)
let employee4 = Person(firstName: "Rocky", lastName: "Darkholer", birthDay: Date(timeIntervalSince1970:502391167), sex: .male, qualification: .specialist, salary: 5500.00, department: "iOS", longTermEmployee: false)
let employee5 = Person(firstName: "John", lastName: "Hard", birthDay: Date(timeIntervalSince1970:420926596), sex: .male, qualification: .projectManeger, salary: 1000.00, department: "Testing", longTermEmployee: false)
let employee6 = Person(firstName: "Spanky", lastName: "Jackin", birthDay: Date(timeIntervalSince1970:899308977), sex: .female, qualification: .specialist, salary: 2300.00, department: "UX-Design", longTermEmployee: true)
let employee7 = Person(firstName: "Don", lastName: "Cream", birthDay: Date(timeIntervalSince1970:863703933), sex: .male, qualification: .companyManeger, salary: 10000.00, department: "Manegement", longTermEmployee: true)
let employee8 = Person(firstName: "Dunkin", lastName: "Fill", birthDay: Date(timeIntervalSince1970:834956712), sex: .male, qualification: .juniorSpecialist, salary: 2000.00, department: "iOS", longTermEmployee: false)
let employee9 = Person(firstName: "Slick", lastName: "Grunter", birthDay: Date(timeIntervalSince1970:752169855), sex: .male, qualification: .specialist, salary: 5400.00, department: "iOS", longTermEmployee: false)
let employee10 = Person(firstName: "Jenna", lastName: "Cream", birthDay: Date(timeIntervalSince1970:642514978), sex: .female, qualification: .departmentManeger, salary: 8500.00, department: "iOS", longTermEmployee: false)
let employee11 = Person(firstName: "Sally", lastName: "Starr", birthDay: Date(timeIntervalSince1970:682549728), sex: .male, qualification: .projectManeger, salary: 6500.00, department: "iOS", longTermEmployee: false)

var employees: [Person]
employees = [employee1, employee2, employee3, employee4, employee5, employee6, employee7, employee8, employee9, employee10, employee11]

// Helper Functions
func epochToHumanReadableDateConverter(epochDate: Date) -> String{
    let currentDate = epochDate
    let format = DateFormatter()
    format.timeZone = .current
    format.dateFormat = "dd.MM.yyyy"
    let dateString = format.string(from: currentDate)
    return dateString
}

func humanReadableDateToEpochConverter(seconds: Int, minutes: Int, hours: Int, day: Int, month: Int, year: Int) -> Int {
    if day > 0 && day <= 31 {
        if month > 0 && month <= 12 {
            if year > 1900 && year < 2020 {
             // Logic goes here

            // 894804100
            // 923529600

            var finalEpochTime: Int = 0

            finalEpochTime += seconds
            finalEpochTime += minutes * 60
            finalEpochTime += hours * 3600
            finalEpochTime += (day - 1) * 86400
            finalEpochTime += (month - 1) * 2629800
            finalEpochTime += (year - 1970) * 31557600

            return finalEpochTime
            }
        }
    }
}
//print(humanReadableDateToEpochConverter(seconds: 0, minutes: 0, hours: 0, day: 5, month: 0, year: 1970))


// --------------
// Task functions
// --------------

// Task 1
func taskOne(employees:[Person]){

    // Sort employees by 1 - birthdays
    let sortedByBirthDay = employees.sorted(by: {$0.birthDay < $1.birthDay})

    // Print out sorted employees
    for printPerson in sortedByBirthDay {
        print("Vārds: \(printPerson.firstName) | Uzvārds: \(printPerson.lastName) | Dzimšanas Diena: \(epochToHumanReadableDateConverter(epochDate: printPerson.birthDay))")
    }
}

// Task 2
func taskTwo(employees:[Person], sex: String, department: String, qualificationA: String, qualificationB: String){

    var filteredEmployees: [Person] = []

    // Filter out needed employees
    for currentEmployee in employees {
        if currentEmployee.sex.rawValue == sex, currentEmployee.department == department && (currentEmployee.qualification.rawValue == qualificationA || currentEmployee.qualification.rawValue == qualificationB) {
            filteredEmployees.append(currentEmployee)
        }
    }

    // Sort employees by 1 - experience ; 2 - salary
    //let sortedEmployees = filteredEmployees.sorted {($0.qualification, $0.salary) < ($1.qualification, $1.salary)}
    let sortedEmployees = filteredEmployees.sorted {
        if $0.qualification != $1.qualification {
            return $0.qualification.rawValue < $1.qualification.rawValue
        } else {
            return $0.salary < $1.salary
        }
    }

    // Print out sorted employees
    for printPerson in sortedEmployees {
        print("Uzvārds: \(printPerson.lastName) | Vārds: \(printPerson.firstName) | Pieredzes līmenis: \(printPerson.qualification.rawValue) | Alga: \(printPerson.salary)")
    }
}


// Task 3
func taskThree(employees: [Person], sex: String){

    var sameSexEmployeeAmountInDepartment: Int
    var sameSexEmployeesInEachDepartmentDict = [String: Int]()
    var totalSameSexEmployees: Int = 0

    // Get all possible departments from all employees
    var departments: [String] = []

    for currentEmployee in employees {
        if !departments.contains(currentEmployee.department) {
            departments.append(currentEmployee.department)
        }
    }

    // Iterate through all departments
    for currentDepartment in departments {

        // Keep count fresh for each department
        sameSexEmployeeAmountInDepartment = 0

        // Iterate through all employees
        for currentEmployee in employees {
            if currentEmployee.department == currentDepartment && currentEmployee.sex.rawValue == sex {
                sameSexEmployeeAmountInDepartment += 1
            }
        }

        // Add the sum of employees in one department to the whole company amount of employees
        totalSameSexEmployees += sameSexEmployeeAmountInDepartment

        // Add department and it's employee amount to dictionary
        sameSexEmployeesInEachDepartmentDict[currentDepartment] = sameSexEmployeeAmountInDepartment
    }

    // Add the last key and value
    sameSexEmployeesInEachDepartmentDict["Company Total"] = totalSameSexEmployees

    print(sameSexEmployeesInEachDepartmentDict)
}

// Main
print("\n---=== TASK 1 ===---")
print("---Description: All employees sorted by birthdays")
taskOne(employees: employees)

print("\n---=== TASK 2 ===---")
print("---Description: All Z department males with X or Y qualification. Sort by 1) qualification level 2) salary")
taskTwo(employees: employees, sex: "male", department: "iOS", qualificationA: "junior specialist", qualificationB: "specialist")

print("\n---=== TASK 3 ===---")
print("---Description: Dictionary with key as department name and value as number of employees in that department. Last key contains whole company and value - total amount of male employees")
taskThree(employees: employees, sex: "male")

