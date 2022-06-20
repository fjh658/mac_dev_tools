### instruments, AccessibilityInspector etc do not depend on xcode to work, used for remote app diagnosis.
#### Usage
- dmg
<img width="567" alt="image" src="https://user-images.githubusercontent.com/5550316/171799665-d4c5d67c-ee50-4d69-afda-a771ec2be5b4.png">

- app remove quarantine
  ```
   xattr -rd com.apple.quarantine /Applications/Instruments.app
   xattr -rd com.apple.quarantine /Applications/Accessibility\ Inspector.app
  ```

#### Build
- Project structure
<img width="465" alt="image" src="https://user-images.githubusercontent.com/5550316/174644651-2f891364-cad2-4aab-8f39-b384c61ecb59.png">


- Generate standalone instruments app
```
sh gen_standalone_instruments_13.4.1.sh
```

- Generate standalone AccessibilityInspector app
```
sh gen_standalone_AccessibilityInspector_13.4.1.sh
```
