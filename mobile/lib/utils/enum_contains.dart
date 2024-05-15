// enum alphabet {a, b, c}
// 위 enum alphabet의 원소로 문자열 name이 속하는지 확인합니다

// e.g., isInEnum(alphabet.values, 'a') // true
// e.g., isInEnum(alphabet.values, 'zzzzz') // false

// 입력 파라미터
// - enumValues: Enum.values (List<Enum>)
// - name : String

bool enumContains<T extends Enum>(List<T> enumValues, String name) {
  final contains = enumValues.any((e) => e.toString().split('.')[1] == name);
  print("-------- $contains");
  return contains;
}
