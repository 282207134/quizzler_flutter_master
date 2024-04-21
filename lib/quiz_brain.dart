import 'dart:math'; // 导入dart的数学库，用于生成随机数
import 'question.dart'; // 导入问题模型定义的文件

class QuizBrain {
  int _questionNumber = 0; // 私有变量，用于跟踪当前问题的索引
  late List<Question> _questionBank; // 使用late关键字声明问题库

  QuizBrain() {
    _questionBank = _initQuestionBank(); // 构造函数中初始化问题库
  }

  List<Question> _initQuestionBank() {
    // 初始化问题库的方法，并返回问题列表
    List<Question> questions = [
      Question('有些猫对人类实际上是过敏的', true),
      Question('你可以领一头牛下楼梯，但不可以领它上楼梯。', false),
      Question('大约四分之一的人类骨骼在脚部。', true),
      Question('蜗牛的血是绿色的。', true),
      Question('巴兹·奥尔德林的母亲的娘家姓是“月亮”。', true),
      Question('在葡萄牙，海里小便是非法的。', true),
      Question('没有一张方形的干纸可以被折叠超过7次。', false),
      Question('在英国伦敦，如果你恰巧在国会大厦去世，你理论上有资格获得国葬，因为该建筑被认为是太神圣的地方。', true),
      Question('任何动物产生的最大声音为188分贝。该动物是非洲象。', false),
      Question('两个人的肺的总表面积约为70平方米。', true),
      Question('谷歌最初被称为“Backrub”。', true),
      Question('巧克力会影响狗的心脏和神经系统；几盎司就足以杀死一只小狗。', true),
      Question('在美国西弗吉尼亚州，如果你不小心用车撞到了动物，你可以将它带回家食用。', true),
    ];
    questions.shuffle(Random()); // 使用shuffle方法和Random()函数来随机排序问题
    return questions; // 返回随机排序后的问题列表
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++; // 递增问题索引
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText; // 返回当前问题的文本
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer; // 返回当前问题的正确答案
  }

  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1; // 检查是否已回答所有问题
  }

  void reset() {
    _questionNumber = 0; // 重置问题索引
    _questionBank = _initQuestionBank(); // 重新初始化问题库
  }
}
