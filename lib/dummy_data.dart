import './models/task.dart';
import './models/requirement.dart';
import './models/employee.dart';
import './models/subtask.dart';
import './models/task_type.dart';

/*List<Task> tasks = [
  Task(
      id: 'T1',
      requesting_entity: 'The A company',
      task_type:
          /*TaskType(
          id: 'd1',
          name_of_task: 'Build A DataBase',
          description: 'blah blah blah',
          accomplishment_time: '20 Days'),*/
          "2",
      begin_date: DateTime.now(),
      subtasks: [
        SubTask(
            id: 's1',
            name: 'blah blah blah',
            start_date: DateTime.now().add(Duration(days: 20)),
            end_date: DateTime.now().add(Duration(days: 30)),
            description: 'blahblahblah',
            /*requirements: [
              requirement(
                id: 'r1',
                name: 'flutter',
                description: 'non',
              ),
              requirement(
                id: 'r2',
                name: 'Disgner',
                description: 'non',
              ),
              requirement(
                id: 'r3',
                name: 'SQlServer',
                description: 'non',
              ),
            ],*/
            done: "1"),
        /*SubTask(
            's2',
            'blah blah blah',
            DateTime.now().add(Duration(days: 10)),
            DateTime.now().add(Duration(days: 20)),
            'blahblahblah',
            [
              requirement(
                id: 'r4',
                name: 'asdad',
                description: 'non',
              ),
              requirement(
                id: 'r5',
                name: 'asdasd',
                description: 'non',
              ),
              requirement(
                id: 'r6',
                name: 'SQzxzxc',
                description: 'non',
              ),
            ],
            false)*/
      ],
      status: taskStatus.active)
];
/*Task(
      id: 'T2',
      requesting_entity: 'The B company',
      task_type: TaskType('d2', 'Build A App', 'blah blah blah', '30 Days'),
      begin_date: DateTime.now().add(Duration(days: 30)),
      subtasks: [
        SubTask(
            's1',
            'blah blah blah',
            DateTime.now().add(Duration(days: 30)),
            DateTime.now().add(Duration(days: 40)),
            'blahblahblah',
            [
              requirement(
                id: 'r1',
                name: 'flutter',
                description: 'non',
              ),
              requirement(
                id: 'r2',
                name: 'Disgner',
                description: 'non',
              ),
              requirement(
                id: 'r3',
                name: 'SQlServer',
                description: 'non',
              ),
            ],
            false),
        SubTask(
            's2',
            'blah blah blah',
            DateTime.now().add(Duration(days: 50)),
            DateTime.now().add(Duration(days: 60)),
            'blahblahblah',
            [
              requirement(
                id: 'r4',
                name: 'asdad',
                description: 'non',
              ),
              requirement(
                id: 'r5',
                name: 'asdasd',
                description: 'non',
              ),
              requirement(
                id: 'r6',
                name: 'SQzxzxc',
                description: 'non',
              ),
            ],
            false)
      ],
      status: taskStatus.outOfDeadLine),
  Task(
      id: 'T3',
      requesting_entity: 'The C company',
      task_type: TaskType('d3', 'Build A System', 'blah blah blah', '50 Days'),
      begin_date: DateTime.now().add(Duration(days: 10)),
      subtasks: [
        SubTask(
            's1',
            'blah blah blah',
            DateTime.now().add(Duration(days: 10)),
            DateTime.now().add(Duration(days: 30)),
            'blahblahblah',
            [
              requirement(
                id: 'r1',
                name: 'flutter',
                description: 'non',
              ),
              requirement(
                id: 'r2',
                name: 'Disgner',
                description: 'non',
              ),
              requirement(
                id: 'r3',
                name: 'SQlServer',
                description: 'non',
              ),
            ],
            false),
        SubTask(
            's2',
            'blah blah blah',
            DateTime.now().add(Duration(days: 30)),
            DateTime.now().add(Duration(days: 40)),
            'blahblahblah',
            [
              requirement(
                id: 'r4',
                name: 'asdad',
                description: 'non',
              ),
              requirement(
                id: 'r5',
                name: 'asdasd',
                description: 'non',
              ),
              requirement(
                id: 'r6',
                name: 'SQzxzxc',
                description: 'non',
              ),
            ],
            false)
      ],
      status: taskStatus.finished),
  Task(
      id: 'T4',
      requesting_entity: 'The D company',
      task_type: TaskType('d4', 'Build A Website', 'blah blah blah', '30 Days'),
      begin_date: DateTime.now().add(Duration(days: 60)),
      subtasks: [
        SubTask(
            's1',
            'blah blah blah',
            DateTime.now().add(Duration(days: 60)),
            DateTime.now().add(Duration(days: 70)),
            'blahblahblah',
            [
              requirement(
                id: 'r1',
                name: 'flutter',
                description: 'non',
              ),
              requirement(
                id: 'r2',
                name: 'Disgner',
                description: 'non',
              ),
              requirement(
                id: 'r3',
                name: 'SQlServer',
                description: 'non',
              ),
            ],
            false),
        SubTask(
            's2',
            'blah blah blah',
            DateTime.now().add(Duration(days: 70)),
            DateTime.now().add(Duration(days: 80)),
            'blahblahblah',
            [
              requirement(
                id: 'r4',
                name: 'asdad',
                description: 'non',
              ),
              requirement(
                id: 'r5',
                name: 'asdasd',
                description: 'non',
              ),
              requirement(
                id: 'r6',
                name: 'SQzxzxc',
                description: 'non',
              ),
            ],
            false)
      ]),
];
List<Employee> employees = [
  new Employee(
      DateTime.now().toString(),
      'Abd Ulaziz AlAbd',
      'abdazizabdamaea@gmail.com',
      '0991872415',
      [
        requirement(id: 'r1', name: 'flutter', description: 'non', ),
        requirement(id: 'r2', name: 'Disgner', description: 'non', ),
        requirement(
            id: 'r3', name: 'SQlServer', description: 'non', ),
      ],
      [
        SubTask(
            's1',
            'blah blah blah',
            DateTime.now().add(Duration(days: 60)),
            DateTime.now().add(Duration(days: 70)),
            'blahblahblah',
            [
              requirement(
                  id: 'r1', name: 'flutter', description: 'non', ),
              requirement(
                  id: 'r2', name: 'Disgner', description: 'non', ),
              requirement(
                  id: 'r3', name: 'SQlServer', description: 'non', ),
            ],
            false),
        SubTask(
            's2',
            'blah blah blah',
            DateTime.now().add(Duration(days: 70)),
            DateTime.now().add(Duration(days: 80)),
            'blahblahblah',
            [
              requirement(
                  id: 'r4', name: 'asdad', description: 'non', ),
              requirement(
                  id: 'r5', name: 'asdasd', description: 'non', ),
              requirement(
                  id: 'r6', name: 'SQzxzxc', description: 'non', ),
            ],
            false)
      ],
      false)
];
*/*/
