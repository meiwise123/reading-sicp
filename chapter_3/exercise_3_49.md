## P219 - [练习 3.49]

### 例子 1

设想一台计算机，有打印机和绘图仪两个设备。有两个进程分别处理文档，在处理之前，进程并不知道自身需要什么资源。于是一个进程先获取了打印机，之后发觉自己需要绘图仪。另一个进程先获取了绘图仪，之后发觉自己需要打印机。这时两个进程分别获取了一台设备，等待另一进程用完另一台设备，于是发生死锁。设备并非一开始就分配，而是随着处理过程逐渐分配的，这时就算将设备单独编号也没有用。

对于上述的设备逐渐分配问题，一个经典的方案，是要获取高编号的设备，需要先获取低编号的设备。比如打印机编号为 1，绘图仪编号为 2，这时当 P1 进程需要绘图仪，因为绘图仪编号较高，就将打印机也分配给 P1。但这种分配方法可以防止设备死锁，但会降低处理效率。

### 例子 2

注：此例子来自[这里](https://sicp.readthedocs.io/en/latest/chp3/49.html)。

假设 peter 和 mary 是两夫妇，各自拥有自己的帐号 peter-acc 和 mary-acc。并且两个帐号都将对方的帐号设置成了关联帐号，也即是，当 peter-acc 的余额不足以支付的时候，它会去提取 mary-acc 的余额；而当 mary-acc 的余额不足以支付的时候，它也回去提取 peter-acc 的余额。

现在，考虑这样一种情况， peter 和 mary 分别在不同的地方消费，然后各自账户的余额都不足以支付订单，于是 peter-acc 尝试访问关联帐号 mary-acc ，而 mary-acc 也在同一时间访问 peter-acc ，因为两个帐号都已经被打开，而且两个帐号都试图访问关联帐号，这样就造成了一个死锁：除非 peter 或 mary 的其中一个主动退出账户，否则支付永远都无法完成。

