# QSDispatchQueue


**A Way to control maxConcurrentCount of GCD concurrent queue by dispatch_semaphore**(利用GCD的信号量机制实现控制GCD并发队列最大并发数的方案)

<h2>Installation</h2>

	pod 'QSDispatchQueue'
	
	OR put QSDispatchQueue.h and QSDispatchQueue.m into your project directly.
	
	Then 
	
	#import "QSDispatchQueue.h"

<h2>Usage-Demo1</h2>

	dispatch_queue_t workConcurrentQueue = dispatch_queue_create("com.jzp.async.queue", DISPATCH_QUEUE_CONCURRENT);
    QSDispatchQueue *queue = [[QSDispatchQueue alloc]initWithQueue:workConcurrentQueue concurrentCount:3];
    for (NSInteger i = 0; i < 10; i++) {
        [queue async:^{
            NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
            sleep(1);
            NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
        }];
    }

<h2>Usage-Demo2</h2>

	dispatch_queue_t workConcurrentQueue = dispatch_queue_create("com.jzp.sync.queue", DISPATCH_QUEUE_CONCURRENT);
    QSDispatchQueue *queue = [[QSDispatchQueue alloc]initWithQueue:workConcurrentQueue concurrentCount:1];
    for (NSInteger i = 0; i < 10; i++) {
        [queue sync:^{
            NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
            sleep(1);
            NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
        }];
    }


<h2>Relation</h2>

	http://www.jianshu.com/p/5d51a367ed62

