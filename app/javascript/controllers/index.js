// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import NotesController from "./notes_controller"
import ActivitiesController from "./activities_controller"
application.register("notes", NotesController)
application.register("activities", ActivitiesController)
