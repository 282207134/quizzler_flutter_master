import 'package:flutter/material.dart'; // 导入Flutter材料设计的包
import 'package:rflutter_alert/rflutter_alert.dart'; // 导入rFlutter_Alert包用于弹窗功能
import 'quiz_brain.dart'; // 导入自定义的quiz_brain.dart

QuizBrain quizBrain = QuizBrain(); // 创建QuizBrain类的实例
void main() => runApp(Quizzler()); // 程序入口，运行Quizzler应用

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900, // 设置背景颜色为深灰色
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0), // 水平方向的内边距
            child: QuizPage(), // QuizPage部件，负责展示问题和按钮
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState(); // 创建状态
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = []; // 用于记录答题情况的图标数组
  int score = 0; // 初始化分数为0，用于跟踪用户得分

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer(); // 获取当前问题的正确答案
    setState(() {
      if (quizBrain.isFinished()) {
        // 如果已完成所有问题
        Alert(
          context: context,
          type: AlertType.success,
          title: "完成",
          desc: "你已经完成了所有问题，您的成绩为$score分。", // 弹窗显示最终分数
          buttons: [
            DialogButton(
              child: Text(
                "返回",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        quizBrain.reset(); // 重置问题库以便重新开始
        scoreKeeper = []; // 清空得分记录
        score = 0; // 重置分数
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green, // 用户答对了，添加绿色勾选图标
          ));
          score += 1; // 正确答案，分数加1
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red, // 用户答错了，添加红色错误图标
          ));
        }
        quizBrain.nextQuestion(); // 切换到下一个问题
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(), // 显示当前问题的文本
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white, // 问题文本样式
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green, // 绿色的“正确”按钮
              ),
              child: Text(
                '正确',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0, // 按钮文本样式
                ),
              ),
              onPressed: () {
                checkAnswer(true); // 用户点击“正确”按钮，传入true
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red, // 红色的“错误”按钮
              ),
              child: Text(
                '错误',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white, // 按钮文本样式
                ),
              ),
              onPressed: () {
                checkAnswer(false); // 用户点击“错误”按钮，传入false
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper, // 显示得分图标的行
        )
      ],
    );
  }
}
