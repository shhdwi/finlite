class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});
}
int correctanscount=0;
int totalanscount=6;
const List sample_data = [
  {
    "id": 1,
    "question":
    "Who created Bitcoin?",
    "options": ['Satoshi Nakamoto','Samsung','John Mcafee','China'],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "Where do you store your cryptocurrency?",
    "options": ['Bank account','Floppy Disk','Wallet','In your pocket'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "What is a miner?",
    "options": ['A type of blockchain','An algorithm that predicts the\n next part of the chain','A person doing calculations \n  to verify a transaction','Computers that validate and\n  process blockchain transactions'],

    "answer_index": 3,
  },
  {
    "id": 4,
    "question": "Where can you buy cryptocurrency?",
    "options": [' A private transaction','An exchange','A Bitcoin ATM','All of the above'],
    "answer_index": 3,
  },
  {
    "id": 5,
    "question": "What is a genesis block?",
    "options": ['The first block of a Blockchain','A famous block that hardcoded a \n  hash of the Book of Genesis\n  onto the blockchain','The first block after each \n  block halving','The 2nd transaction of a Blockchain'],
    "answer_index": 0,
  },
  {
    "id": 6,
    "question": "What powers the Ethereum Virtual Machine?",
    "options": ['Gas','Ether','Bitcoin','Block Rewards'],
    "answer_index": 0,
  },
];