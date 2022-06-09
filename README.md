### instruments, AccessibilityInspector etc do not depend on xcode to work, used for remote app diagnosis.
- dmg
<img width="567" alt="image" src="https://user-images.githubusercontent.com/5550316/171799665-d4c5d67c-ee50-4d69-afda-a771ec2be5b4.png">

- Project structure
<img width="451" alt="image" src="https://user-images.githubusercontent.com/5550316/171845810-95c32dc4-6a52-4568-9cd9-6ec2bdf07755.png">

- Generate standalone instruments app
```
cd instruments_script
sh gen_standalone_instruments_13.4.1.sh
```

- Generate standalone AccessibilityInspector app
```
cd AccessibilityInspector_script
sh gen_standalone_AccessibilityInspector_13.4.1.sh
```
