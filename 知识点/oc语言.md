###OC语言 Cocoa
#####面向对象术语
        1、类 +   2、对象‘—’ = = 3、实例  
        一种结构（数据类型），表示对象的类型
        对象是类的变量，包含值和指向其类的隐藏指针  
        对象引用类来获取和本身有关的各种信息，特别是运用什么代码来处理每种操作   :NSObject
          
        4、消息  对象可执行的操作，用于通知对象去做什么
        5、方法  响应消息而运行的代码，根据对象的类，可调用不同的方法
        6、方法调度程序  用于推测执行什么方法来响应某个特定消息
        7、接口  @interface 对象的类应该提供的描述  .h头文件
        8、实现 @implementation 使接口正常运行的代码，对接口逻辑功能具体实现  .m文件
    	@end
    	NSLog()可以使用%@格式说明符来输出对象
    	
    	布尔类型(yes:1 no:0)
    	NSString输出字符串  NSLog 打印的意思
    %@	NSString * boolString(BOOL)的返回值类型是一个指向NSString的指针 字符串
    	%lu格式说明符取计算字符长度
    	
    	@interface用于定义类的公共接口（API）
    	声明新的对象，基于NSObject类，{}内创建新对象的多个模板元素（参数），元素也有自己的类型  实例变量ivar 
    	- 先行短线“新方法的声明”，（void）表明该方法不返回任何值。
    	方法的名称:(参数类型)参数 
    	接口的部分代码：类的@interface指令，公共struct定义，enum常量，#define和extern全局变量
    	 
        @implementation 使对象能够运行代码（实现化）  可以另设方法（动态）
        实例化  id数组元素 指向任意类型的指针 
    	
    继承  类名--实例变量--方法 UML processon  超类superclass  重构（移植和优化）     self指针来自方法调用，指向第一个实例变量  重写
    复合 只有对象间的组合
    	@class “.h文件“”（初始化）的区别  初始化实例变量init
    	
    	
#####    Foundation  oc框架
         coreFoundation  纯C语言框架  函数变量以CF开头 
      1. 常用数据类型  NSRange  NSPoint  NSSize  NSRect
        字符串类型  NSString  NSMutableString 
      几何类型   NSPoint  NSSize  NSRect 
       typedef struct _NSRangl{
          unsigned  int location; 表示范围的位置信息，从0开始计
          unsigned  int  length;表示范围所含元素的个数
       }NSRange;用结构体来表示范围
       NSRang range;
       range.location = 6;
       range.length = 5;
       C语言 赋值 NSRange range = {6,5}
       Cocoa函数   NSRange range = NSMakeRange(6,5); 
       
    	NSPoint 代表笛卡尔平面坐标点(x,y)
    	typedef struct _NSPoint{
    	    float x;
    	    float y;	   	
    	}NSPoint;
    	 
    	 NSSize 用来储存长度和宽度
    	 typedef struct _NSPoint{
    	    float  width;
    	    float  height;
    	 }NSSize;
    	 
    	NSRect  有点和大小复合而成的矩形数据类型
	     typedef  struct _NSREct{
	          NSPoint orgin;
	          NSSize size;
	     }    	
###### 2.
    	NNString NSMutableString  可读的字符串序列   
      	通过各式字符串和参数创建字符串 
      	
      	类方法 + （id）stringWithFormat:(NSString*)format,...;
       
        NSStrng *height;
        height = [NSStingWithFormat:@"Your height is %d feet, %d inches",5,11];
    
    3. 获取字符串长度
    	- （unsigned int）length；
    	NNString *name = @"HeNan QingYun";
    	unsigned int length = [name length];     
    
    4.	字符串相等性比较  指针地址和指针内容
    	- (BOOL)isEqualtoString:(NSString*)aString;
    	NSString *name = @"Power Node 100";
    	NSString *anotherName;
    	anotherName = [NSString stringWithFormat:"Power Node %d",5];
    	if([name isEqualToString:anotherName]){
    		NSlog(@"They are the name");
    	} 
    	
    	- (NSComparisonResult)compare:(NSTring *)string;
    	  
    	  typedef enum _NSComparisonResult{
    	         NSOrederedAsceding = -1,
    	         NSOrderedSame,
    	         NSOrderedDescending,    	  
    	  } NSComparisonResult;
    	  [@"arrdvark" compare: @"zygote"];区分大小写字符
    	  [@"zoinks" compare: @"jinkies"];
    	
      5.字符串的包含和查找
        开头 - （BOOL）hasPrefix:(NSString *)aString;
        结尾 -  (BOOL) hasSuffix:(NSString *）aString;
        包含 -  (NSRange) rangeOfString:(NSSting *)aStrng;   
    	
    	 @autoreleasepool 关键字  return
    
    	NSString  用来存储狂热以看懂的文本
    	+(id)stringWithCapacity:(NSUInteger)capacity     	    NSMutableString *string =[NSMutableString 		stringWithCapacity:26];  分配最优内存值
    	-(void)deleteCharactersInRange:(NSRange)aRange;删除
    	
    	(void)appendString:(NSString *)aString;在字符串后面追加
    	(void)appendFormat:(NSString *)format,...;在后面以格式化字符追加字符串  @“human %d !”
######3。
    	NSArray 有序 NSDictionary  用来存储对象的集合 数组
    	NSArray *array;
    	array =    [NSArry  arrayWithObject:@"one","two","three",nil];
    	+(id)arryWithCapacity:(unsigned)numItens;创建
    	-(void)addObject:(id)anObject;组末添加
    	-（void）removeObjectAtINdex:(unsigned)index;删除
    	枚举
    	-(NSEnumerator *)objectEnumberator 从头到尾
    	-(NSEnumerator *)reverseObjectEnumberator;从尾到头
    	(id)nextObject;判断是否结束
    	快速枚举
    	for(NSString *name in names){
    		NSLog (@"I found the name %@",name);
    	}
    	NSDictionary 关键字及定义的集合 散列表 关联数组
    	+(id)dictionaryWithObjectAndKeys:(id)firstObject,...;
    	NSDictionary *students;
    	students = [NSDictionary 创建dictionaryWithObjectsAndKeys:@"num1",@"num2",@"num3",nil];
    	查询 -(id)objectForkey:(id)key;
    	NSString *student = [students objectForkey:@"num1"];
    	创建对象
    	+(id)dictionaryWithCapacity:(unsigned int)numItems; 
    	增加内容
    	-(void)setObject:(id)anObject forKey:(id)key;
    	删除内容
    	-(void)removeObjectForkey:(id)aKey; 
    	
    	NSNumber   可以将基本数据类型封装成对象（装箱）
    	+（NSNumber *)numberWithChar:(char)value;
    	+ (NSNumber *)numberWithInt:(int)value;
    	+ (NSNumber *)numberWithFloat:(float)value;
    	+ (NSNumber *)numberWithBool:(BOLL)value;
    	获取数据类型（取消装箱）
    	-(char)charValue;
    	-(int)intValue;
    	-(float)floatValue;
    	-(BOOL)boolValue;
    	-(NSString *)stringValue;
    	NSValue 包装任意值
		+(NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;  传递的第一个参数是我们要包装的数值地址，第二个字符串用来描述包装这个数值的数据类型 @encode来获取
		NSValue *value = [NSValue valueWithBytes:&rect objCType:@encode(NSSRect)];
        [array addObject:value];
        -(void)getValue:(void*)value;提取    	
    	NSRect rect = NSMakerect(1,2,30,40)；
    	
    	
    	+(NSNull *)null;返回表示什么都没有
    	BOOL = typedef signed char  8 

#####内存管理
     对象生命周期
                        借助方法的组合和参数
		诞生  --  生存  --  交友  --  销毁
	 alloc，new  接收消息和执行操作     内存被释放
	 引用计数 (id)retain +1   (void)release -1                 
	 (void)dealloc  计数器变零即将被销毁时，Object-C自动向对象发送dealloc消息
	 （unsigned）retainCount  计数器的值
	 自动释放
	 -（id）autorelease;
	NSAutoreleasePool *pool;
	pool = [[NSAutoreleasePool alloc] init];	[pool release];
     “如果我使用了new , alloc 或者copy方法获得一个对象，则我必须释放或自释放该对象。”
     如果你对对象调用了retain消息，那么你必须负责释放(release)这个对象，保证retain和release的使用次数相等。
     iPhone应用程序开发，不允许使用垃圾回收机制，也不建议使用自动释放对象。
    
####ARC
  
    1.不能直接调用dealloc方法，不能调用retain，release，autorelease，retainCount方法，包括@selector(retain)的方式也不行
    2.如果你需要管理资源而不是释放实例变量，你应该实现dealloc方法。不能在dealloc方法里面去掉[super dealloc]方法，在ARC下父类的dealloc同样由编译器来自动完成      
    3.Core Foundation类型的对象任然可以用CFRetain，CFRelease这些方法
    4.不能在使用NSAllocateObject和NSDeallocateObject对象   5.不能在c结构体中使用对象指针，如果有类似功能可以创建一个Objective-c类来管理这些对象  
    6.在id和void *之间没有简便的转换方法，同样在Objective-c和core Foundation类型之间的转换都需要使用编译器制定的转换函数
    7.不能再使用NSAutoreleasePool对象，ARC提供了@autoreleasepool块来代替它，这样更加有效率 
     8.不能使用内存存储区（不能再使用NSZone）
     9.不能以new为开头给一个属性命名
    10.声明outlet时一般应当使用weak，除了对StoryBoard 这样nib中间的顶层对象要用strong
    11.weak 相当于老版本的assign，strong相当于retain	
    	
    	
#####初始化   	
    + (id) alloc;
    对象的诞生过程，主要是从操作系统获得一块足够大的内存，以存         放该类的全部实例变量，并将其指定为存放对象的实例变量的位置。
    alloc方法同时将这块内存区域全部设置为0。（由于其它语言没有初始化带来了很多问题），结果是：BOOL变量初始值为NO, 所有的int类型变量为0，float变量为0.0，所有的指针为nil.	
    - (id) init;
    初始化的功能就是保障我们的实例变量是可用的完整的对象，如：我们在初始化中给类中依赖的其它的实例变量赋值
    有两种初始化思想。第一种就是初始化方法中将所有相依赖的对象全部创建并赋值，“开箱即用”；第二种是惰性求值，就是在初始化的时候先占位，然后再使用的时候，再确认具体的值。这两种方法需要根据业务来进行取舍。
    - (id) init{		if ( self = [super init]) {				//do something init content...		}	return 0;
    }
    
     在子类化的时候，为了保证父类能正常初始化，就需要重写父类所有的初始化方法和便利初始化方法，并添加子类成员变量的初始，这样就会导致，当父类修改或者添加初始化方法的时候，子类需要做相应的修改。这样的设计偏离了高内聚低耦合的设计原则。
    	指定初始化函数
    类中某个初始化方法被指派为指定初始化函数。该类的所有初始方法都使用指定初始化方法执行初始化操作。而子类使用其超类的指定初始化方法进行超类的初始化。
    一般情况下，接收参数最多的初始化方法是最终的指定初始化方法，因为它的初始化信息较全面。
    并不是一定要为自己的类创建初始化函数，如果不需要设置作何状态，或者alloc方法将内存清零的默认结果满足需求，则不必考虑init
    如果创建了指定初始化方法， 则一定要在自己的指定初始化函数中调用超类的指定初始化函数
    如果初始化函数不止一个，则需要选择一个作为指定初始化函数。
    /NSObject *obj = [NSObject new]; // 默认走的是先alloc然后调用init
      NSObject *obj1 = [[NSObject alloc] init]; // 实际对一个设计成功的类来说，会提供各种初始化方法，所以在alloc之后，应该根据不同需求来选择合适的初始化方法，所以我们要摈弃new的写法
#####属性 
    
    使用特性我们可以避免手工编写繁琐的setter 和 getter方法，避免因为这些方法来内存的问题，同时也节省编写代码的时间。
    @property  新的编译器指令，主要功能是为我们自动“生成”，setter和getter方法的声明。（注意：我们是看不到这些代码的）
     @synthesize 与@property相对应的新的编译器功能。主要是为我们自动生成，setter和getter方法的功能实现。（注意：我们也不会看到相应的代码）
      使用了@property和@synthesize后，我们在setter和getter方法调用的地方可以使用点( . )操作来代替函数调用。
     assign   //简单赋值，主要用于基本数据类型
     copy  //创建一个新的对象，新的对象和旧对象是独立的两个对象
     retain //将对象计数器加1
     readonly //表示只读属性  只会生成getter方法 不会生成setter方法
    readwrite //默认值，表求生成setter和getter方法
    nonatomic //非原子访问，不加同步 ，多线程并发访问提高性能 （对多线程的保护，防止在未写完，被另一个线程读取，造成数据错误）
    实列变量与属性名称要求不同需求如何解决？    @synthesize name = appellation;重命名
    
    @dynamic
    告诉编译器不要生成任何代码或创建相应的实例变量
    
    
#####便利化初始化   
    - (id) initWithContentOfFile: (NSString *) path encoding:(NSStringEncodeing) enc error:(NSError **)error
    功能是读取磁盘文件的内容，初始化一个字符串对象
    encoding用于说明文件内容的编码格式，比如：GBK UTF8等，一般来说没有特殊情况，使用NSUTF*StringEncoding.
     error参数如果正常初始化了，则返回nil，否则返回错误的信息， 这些信息封装成NSError对象，可以使用%@格式符打印出来， 也可以使用NSError的对象方法：localizedDescription打印错误信息。
    注意：error是指针的指针
    
    
#####类别
    category
    为现有的类（自定义的类、第三方的类或者是系统定义的类）添加一些新的行为
    Objective-C的动态运行时分配机制
     为现有的类添加新的行为，通常也可以采用创建子类的方法， 但是它是有限制的， 如现有的类你没有源代码， 或者现有的类是类簇的形式存在。都无法添加新的行为
    类别代码习惯放在独立的文件中，通常会以”类名称＋类别名称”的风格命名。如：NSString+NumberConvenience，其含义是为现有的类NSString添加一个名为NumberConvenicence的类别。
    缺点
    无法向类别中添加新的实例变量
    名称冲突。注意：类别具有最高的优先级
    优点
    将类的实现代码分散到多个不同文件或框架中。
    创建对私有方法的前向引用
    向对象添加非正式协议
    
    类别的实现和扩展 class extern
    没有名字的类别
    可以在源代码类里使用。
    可以添加实例变量，作为类的私有变量
    可以将只读权限改成可读写的权限
    创建数量不限
    
    利用类别分散实现代码
    在大型的项目中， 一个类的实现可能非常大，并且.m文件不能分离。但是使用类别可以将一个类的实现分散且有规律的组织在不同的文件中。还可以将一个类的实现分散到不同的框架中。 
    编程人员可以更加容易阅读代码并实现多人合作编码
     版本管理降低冲突
     维护人员更容易理解代码
    
    通过类别创建前向引用和方法声明
     Cocoa没有真正的私有的方法， 但是如果你知道对象支持的某个方法的名称，就算是该对象所在的类的接口中没有声明这个方法，也可以调用他。因为可以使用类别告诉编译器此方法已经声明了。 
     越狱项目中常常使用类别的这个功能，完成调用私有API。
     注意：苹果官方上架AppStroe的一个原则是不允许访问类里面的私有变量和方法。    如果开发的是非越狱程序，注意这条规则。
     
     
#####协议
	协议(Protocol)
	所谓协义就是为了完成某一任务，制订的规则，约束大家来共同遵守。
    正式协议是包含了方法和属性的有名称的列表。与非正式协议的区别是正式协议要求显示的采用。采用协议意味着你承诺实现该协议的所有方法。
    Objective-C语方中的协议类似JAVA中的接口。
    
    采用多个协议的时候， 顺序对结果不会造成影响。
    采用了某个协议，就相当于给阅读该类的编程人员传递了一条信息，表明该类的对象可以完成两个非常重要的操作：1､对自身进行编码或解码 2､能够创建自身的副本。
    @optional 和 @required关键字：    @optional限定的方法表示协议中相应的方法可以选择来实现；
    @required限定的方法表示遵守协议的类必须实现对应的方法。
    
    浅拷贝 (shallow copy)
    不会复制所引用的对象，新复制的对象只会指向现有的引用对象上。
    深拷贝（deep copy)
    真正意义的复制概念。得到的结果是多个，而非只是对象的引用 
    代码块(Blocks) 
    代码块对象简称为“代码块“
    <returntype> (^blockname)(list of arguments) = ^(arguments){body;};
    void (^theBlock)() =  ^{printf(“hello,QingYun”)};
     theBlock(); //这里没有幂符号，因为只有在定义代码块的时候才会使用幂符号。调用的时候不能使用
    由于代码块的局部变量在编译阶段被看作为常量，所以在代码块内部是无法修改的
    采用__block修饰的话，可以在代码块内部修改局部变量
    本地变量：与代码块在同一范围内声明的变量。
    全局变量   形参变量：
    直接调用代码块  代码块内联
    
     关于系统类的拷贝结论
        
    1 搞清楚copy和赋值并不是一回事，copy实际是发送过copy消息之后执行了copyWithZone的方法来实现的
    赋值就是一层强引用的关系 
    2 不可变的NSString,NSArray,NSDcitionary的copy是浅拷贝
    3 可变的NSString,NSArray,NSDcitionary的copy是深拷贝，拷贝之后得到的都是不可变的
    4 不可变的NSString,NSArray,NSDcitionary的mutableCopy是深拷贝，而且拷贝之后都变成可变的
    5 可变的NSString,NSArray,NSDcitionary的mutableCopy是深拷贝
    6 不管是深拷贝还是浅拷贝，对于集合类型而言，集合中的元素都是浅拷贝 
    
    
      
     * 关于定时器的这种用法
     * scheduledTimerWithTimeInterval接收的参数表示定时器的时间间隔
     * target接收的参数代表将来执行相应操作的对象
     * selector接收的参数表示将来要执行的操作
     * userInfo接收的参数表示在该方法中需要传递的其他对象
     * repeats的参数表示此定时去是否重复执行
     * selector:@selector(timeCount:)这个方法参数后面的冒号表示必须有参数，而这里的参数就是指该计时器本身
     
     // 在命令行模式下计时器需要启动主运行环才能生效，所以下面一行的代码就开启主运行环
    [[NSRunLoop currentRunLoop] run];
    [self respondsToSelector:method]
    SEL method = @selector(wakeUp:)
    * 使用非正式协议实现老师叫醒学生
    * 从类的设计角度来说，叫醒这个行为并不是老师类的特有行为
    * 所以只是使用非正式协议来简单实现，并且在此过程中，学生睡觉不能自己叫醒自己，那么这个实现就是一个委托或者叫代理（delegate）
    * 代理是iOS开发中一种很重要的实现方式，所以需要理解代理的设计方法

    // SEL可以视为声明方法作为参数传递的类型
    // 方法后有冒号和没有冒号完全是两个概念，有冒号表示有参数
    