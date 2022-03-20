# Todo app

## _A simple todo app, where you can add, edit and delete todo tasks_

## Table of Contents
* [Packages used](#packages-used)
* [Scenes](#scenes)

## Packages used
- [ReSwift](https://github.com/ReSwift/ReSwift) 
- [SnapKit](https://github.com/SnapKit/SnapKit)
- [RxSwift](https://github.com/ReactiveX/RxSwift)

## Scenes
- **OnboardingViewController** - this is the initial page to be seen when the app is run and user is not yet authenticated.
- **SigninViewController** - page consists of email and password field which are needed for signing in.
    * Field Validations:
        - Email field should not be empty.
        - Password field should be at least six in characters.
- **SignupViewController** - page where user enters his name, email, password and will be asked to confirm the password for the sign up process.
    * Field Validations:
        - Name field should not be empty and minimum of four characters.
        - Email field should not be empty.
        - Password field should be at least six in characters.
        - Password Confirmation field should match the password field.
- **HomeViewController** - page where all tasks are listed. Some actions button are seen also like add, edit and delete feature for the task.
- **TaskFormViewController** - page where user can enter details needed for the creation or editing of task.
    * Field Validations:
        - Title field should be at least four in characters.
