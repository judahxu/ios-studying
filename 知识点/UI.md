###UI
iOS应用程序特点    
只有一个应用程序在运行    
只有一个窗口    
有限的屏幕大小    
有限的系统资源：内存、存储空间、电量   
有限的响应时间    
访问受限    
不支持垃圾回收   

iOS中的沙盒机制（SandBox）是一种安全体系，它规定了应用程序只能在为该应用创建的文件夹内读取文件，不可以访问其他地方的内容。所有的非代码文件都保存在这个地方，比如图片、声音、属性列表和文本文件等。   
每个应用程序都在自己的沙盒内   
不能随意跨越自己的沙盒去访问别的应用程序沙盒的内容   
应用程序向外请求或接收数据都需要经过权限认证   

NSString *path = NSHomeDirectory();   
NSLog(@"sandbox path:%@",path);   
#####1
AppDelegate（.h/.m）：应用程序代理，主要用于监听整个应用程序生命周期中各个阶段的事件    
ViewController（.h/.m）：视图控制器，主要负责管理UIView的生命周期、负责UIView之间的切换、对UIView事件进行监听等   
Main.storyboard：界面布局文件，承载对应UIView的视图控件    
Images.xcassets：应用程序图像资源文件    
Info.plist：应用程序配置文件    
main.m：应用程序入口函数文件    
xxx-prefix.pch:项目公共头文件，此文件中的导入语句在编译时会应用到所有的类文件中  

 main函数是程序启动的入口，在iOS app中，main函数的功能被最小化，它的主要工作都交给了UIKit framework   
UIApplicationMain函数有四个参数，你不需要改变这些参数值，不过我们也需要理解这些参数和程序是如何开始：argc 和argv参数.  
第三个参数确定了主要应用程序类的名称，这个参数指定为nil，这样UIKit就会使用默认UIApplication类创建对象。第四个参数是程序自定义的代理类名，这个类负责系统和代码之间的交互。它一般在Xcode新建项目时会自动生成。    

重点理解，UIApplicationMain做的三件事：   
1､根据第三个参数创建UIApplication对象       
2、根据第四个参数创建应用程序的delegate，并设置delegate               
3、设置主事件循环(main event loop)包括application的run loop,同时开始处理事件。      
#####2

Not running（未运行 ）                   程序没启动         
Inactive （未激活）                        程序在前台运行，不过没有接收到事件         
Active（激活）                程序在前台运行而且接收到了事件。这也是前台的一个正常的模式         
Backgroud（后台）               程序在后台而且能执行代码，大多数程序进入这个状态后会在在这个状态上停留一会。时间到之后会进入挂起状态         (Suspended)。有的程序经过特殊的请求后可以长期处于       Backgroud状态        
Suspended（挂起）            程序在后台不能执行代码。系统会自动把程序变成这个状态而且不会发出通知，程序还是停留在内存中的，系统内存低时，系统就把挂起的程序清除掉，为前台程序提供更多的内存    

应用程序生命周期指的是应用程序从启动到应用程序结束整个阶段的全部过程   
每一个iOS应用程序都包含一个UIApplication对象，iOS系统通过该对象监控程序生命周期的全过程      
每一个iOS应用程序都要为其UIApplication对象设置一个代理对象，并由该代理对象处理UIApplication对象监测到的应用程序生命周期的事件       
#####3
什么是UIView     
在iPhone里你看到的、摸到的都是UIView，所以UIView在iPhone开发里具有非常重要的作用。UIView是iPhone应用程序中所有界面的基础。UIView在屏幕上定义了一个矩形区域和管理区域内容的接口。在运行时，一个视图对象控制该区域的渲染，同时也控制内容的交互。    
UIView的基本功能     
UIView具有三个基本的功能，画图和动画，管理内容的布局，控制事件。  
什么是UIWindow    
UIWindow是一种特殊的UIView，通常在一个app中只会有一个UIWindow。iOS程序启动完毕后，创建的第一个视图控件就是UIWindow，接着创建控制器的view，最后将控制器的view添加到UIWindow上，于是控制器的view就显示在屏幕上了一个iOS程序之所以能显示到屏幕上，完全是因为它有UIWindow。     
UIWindow、UIView的关系       
从继承关系上讲UIWindow继承自UIView，从界面布局上来看UIWindow又为所有视图提供了一个显示的容器。         
UIWindow的创建        
用StoryBoard布局界面会直接生成一个UIWidow，并加入一个视图控制器。          
创建一个Empty Application，可以看到系统创建UIWindow并显示的具体细节。         
 与直角坐标系的差别      
回忆CGPoint、CGSize、CGRect       
iOS坐标系的几个要素      
bounds，在自身视图中的CGRect       
frame，在父视图的CGRect        
center，在父视图中的CGPoint       
origin，左上角所在的CGPoint（偏移量）      
######4
frame与bounds的区别在于参照物的区域别，前者是相对父视图而言，后者则是以视图本身的的本地坐标系统为参照，而center则是视图物理中心点相对于父视图坐标原点的偏移量。         
即使你可以独立的改变frame，bounds和center属性，其中一个改变还是会影响到另外两个属性：          
当你设置了frame属性，bounds属性的尺寸值也改变来适应      frame矩形的新尺寸。center属性也会改变为新frame矩形的中心值。         
当你设置了center属性，frame的原点也会相应的改变。    
当你设置了bounds属性，frame属性会改变以适应bounds矩形的新尺寸。 

除了提供自己的内容之外，一个视图也可以表现得像一个容器。当一个视图包含其他视图时，就在两个视图之间创建了一个父子关系。在这个关系中孩子视图被当作子视图，父视图被当作超视图。创建这样一个关系对应用的可视化和行为都有重要的意义。      

在视觉上，子视图隐藏了父视图的内容。如果子视图是完全不透明的，那么子视图所占据的区域就完全的隐藏了父视图的相应区域。如果子视图是部分透明的，那么两个视图在显示在屏幕上之前就混合在一起了。每个父视图都用一个有序的数组存储着它的子视图，存储的顺序会影响到每个子视图的显示效果。如果两个兄弟子视图重叠在一起，后来被加入的那个（或者说是排在子视图数组后面的那个）出现在另一个上面。       

父子视图关系也影响着一些视图行为，改变父视图的尺寸会连带着改变子视图的尺寸和位置。在这种情况下，你可以通过合适的配置视图来重定义子视图的尺寸。其他会影响到子视图的改变包括隐藏父视图，改变父视图的alpha值，或者转换父视图。       

视图层次的安排也会决定着应用如何去响应事件。在一个具体的视图内部发生的触摸事件通常会被直接发送到该视图去处理。然而，如果该视图没有处理，它会将该事件传递给它的父视图，在响应者链中以此类推。具体视图可能也会传递事件给一个干预响应者对象，像视图控制器。如果没有对象处理这个事件，它最终会到达应用对象，此时通常就被丢弃了。                
#####5
UIViewController的概念    
顾名思义UIViewController是用来控制视图的。官方UIViewController的解释：视图控制器为iPhone的应用程序提供了基础的视图管理模型，你可以使用视图控制器管理视图的层次结构和展现形式。    
UIViewController的作用    
作用一：管理视图的展示      
作用二：处理对视图的交互操作       
常用的有导航控制器UINavigationController、标签栏控制器UITabBarController、表视图控制器UITableViewController等。

第一次访问UIViewController的view时，view为nil，然后就会调用loadView方法创建view   
view创建完毕后会调用viewDidLoad方法进行界面元素的初始化
当内存警告时，系统可能会释放UIViewController的view，将view赋值为nil    
当再次访问UIViewController的view时，view已经在3中被赋值为nil，所以又会调用loadView方法重新创建view   
view被重新创建完毕后，还是会调用viewDidLoad方法进行界面元素的初始化     

只有Controller中，有对Model和View的直接引用，直观来，就是需要包含引用的类声明的头文件和类的实例变量。
然后View是怎么向Controller通讯的？iOS中有3种常见的模式:
设置View对应的Action Target。如设置UIButton的Touch up inside的Action Target。
设置View的delegate，如UIAlertViewDelegate, UIActionSheetDelegate等。
设置View的data source, 如UITableViewDataSource。 
通过这3种模式，View达到了既能向Controller通讯，又不需要知道具体的Controller是什么目的。
Model主要是通过Notification、KVO来和Controller通讯。
Model和View永远不要直接通信。
最后一个完整的App就是很多MVC的集合。

#####6
   UILable显示文本用于内容提示
   UIImageView用于显示图片 简单得多图动画
   UIActivityIndicatorViewStyle用于在交互过程中提示用户应用程序在后台执行某些动作，比如网络请求、数据库操作等常见动作。加载
   UIAlertView用于提示用户相关信息，并与用户交互，通常情况下该提示非常重要，需要用户做出选择并最终确认。
   UIActionSheet类似于UIAlertView的功能，但从屏幕下方弹出。
   UIColor  UIFont  UIImage