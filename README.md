# secured_flutter_app

Имеется некая строка с чувствительными данными. Необходимо произвести ресерч и по его результатам реализовать решение для хранения и работы с этими данными. Решение должно использовать безопасные средства хранения предоставляемые операционной системой, желательно аппаратные, если такое возможно в рамках платформы.

Результат выполненного тестового задания должен быть в виде flutter приложения, со следующим функционалом:
импорт строки, установка пин-кода для доступа и сохранение в защищенном хранилище выбранном на этапе ресерча.
Возможность экспорта строки из хранилища с использованием установленного ранее пин-кода.
Возможность использования биометрии для получения доступа без ввода пин-кода.
Решение должно быть устойчивым к перебору пин-кода, в том числе защита от перебора не должна обходиться перезапуском либо переустановкой приложения.



There is a certain string with sensitive data. It is necessary to perform a reserch and, based on its results, implement a solution for storing and working with this data. The solution should use secure storage facilities provided by the operating system, preferably hardware, if this is possible within the framework of the platform.

The result of the completed test task should be in the form of a flutter application, with the following functionality:
importing a string, setting a PIN code for access and saving it in a secure storage selected at the stage of retrieval.
The ability to export a string from storage using a previously installed PIN code.
The ability to use biometrics to gain access without entering a PIN code.
The solution should be resistant to pin code brute force, including brute force protection should not be done by restarting or reinstalling the application.
