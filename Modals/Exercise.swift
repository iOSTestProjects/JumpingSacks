//
//  Exercise.swift
//  InterviewTasks
//
//  Created by Thejas K on 21/09/21.
//

import Foundation

struct Exercise : Decodable {
    let currentdate : String
    let data : [ExerciseDetails]
    let status : Int
}

struct ExerciseDetails : Decodable {
    let date : String
    let data : [ExerciseData]
}

struct ExerciseData : Decodable {
    let id : Int
    let schedulId : Int
    let userId : Int
    let completedOn : String
    let currentDate : String
    let workouts : Workouts
}

struct Workouts : Decodable {
    let workoutDetails : WorkoutDetails
    let stages : [Stages]
}

struct WorkoutDetails : Decodable {
    let workoutDetails : String
    let workoutName : String
    let day : String
    let inComplete : String
}

struct Stages : Decodable {
    let id : Int
    let mainExerciseName : String
    let exerciseSets : Int
    let exerciseList : [ExerciseList]
}

struct ExerciseList : Decodable {
    let exerciseId : Int
    let name : String
    let setReps : String
    let sort : Int
}
