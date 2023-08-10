From: 梁礼学 <lianglixuehao@126.com>
Date: Thu, 10 Aug 2023 09:14:49 +0800 (CST)
Subject: [PATCH] i2c: aspeed: Avoid accessing freed buffers during
 i2c transfers.
In-Reply-To: <20230805101004.dknxj7nqrt2aes5n@intel.intel>
References: <20230728122416.17782-1-lianglixuehao@126.com>
 <20230805101004.dknxj7nqrt2aes5n@intel.intel>
Message-ID: <2424af0e.b0f.189dd02b51a.Coremail.lianglixuehao@126.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andi?
  The panic information is as follows?
-----------------------------------------------------------------
[ 1151.952042] 8<--- cut here ---
[ 1151.955135] Unable to handle kernel paging request at virtual address 0f810000
[ 1151.962365] pgd = cd42b096
[ 1151.965079] [0f810000] *pgd=00000000
[ 1151.968670] Internal error: Oops: 5 [#1] ARM
[ 1151.972939] Modules linked in:
[ 1151.976008] CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.10-7b61b9e-dirty-8281d37 #1
[ 1151.983658] Hardware name: Generic DT based system
[ 1151.988473] PC is at aspeed_i2c_bus_irq+0xec/0x510
[ 1151.993280] LR is@__handle_irq_event_percpu+0x48/0x1c4
[ 1151.998678] pc : [<804ca858>]    lr : [<8014f1a8>]    psr: 80000193
[ 1152.004933] sp : 80a01da0  ip : 00000001  fp : 80a01dc4
[ 1152.010149] r10: 80a01e08  r9 : 00000000  r8 : 00000001
[ 1152.015370] r7 : 00000000  r6 : 00000001  r5 : 00000000  r4 : 94cdfa20
[ 1152.021887] r3 : 00000000  r2 : 00000000  r1 : 9f028180  r0 : 0f810000
[ 1152.028406] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1152.035625] Control: 00c5387d  Table: 8e048008  DAC: 00000051
[ 1152.041376] Process swapper (pid: 0, stack limit = 0x44876230)
[ 1152.047204] Stack: (0x80a01da0 to 0x80a02000)
[ 1152.051574] 1da0: 94cd3940 9e0020e0 9e080910 80a2d90c 0000002b 00000000 80a01e04 80a01dc8
[ 1152.059754] 1dc0: 8014f1a8 804ca778 80a49edc 00000001 9e014600 9e11eda0 00000000 9e11eda0
[ 1152.067934] 1de0: 9e0020e0 9e080910 80a2d90c 00000000 80a00000 80a61a80 80a01e24 80a01e08
[ 1152.076106] 1e00: 8014f360 8014f16c 00000000 80a03028 9e11eda0 9e0020e0 80a01e3c 80a01e28
[ 1152.084279] 1e20: 8014f3f4 8014f330 9e11eda0 9e0020e0 80a01e54 80a01e40 80152d48 8014f3c8
[ 1152.092452] 1e40: 00000005 9e0020e0 80a01e64 80a01e58 8014e44c 80152cc4 80a01e8c 80a01e68
[ 1152.100623] 1e60: 803d1a7c 8014e428 00000020 80a03028 00000010 80a49edc 00000001 9e014600
[ 1152.108797] 1e80: 80a01e9c 80a01e90 8014e44c 803d1a0c 80a01ec4 80a01ea0 8014eaa4 8014e428
[ 1152.116970] 1ea0: 9e002e40 80a01ee0 ffffffff 80a01f14 80a03020 80a00000 80a01edc 80a01ec8
[ 1152.125143] 1ec0: 801021cc 8014ea58 80103e6c 60000013 80a01f3c 80a01ee0 80101a6c 80102170
[ 1152.133315] 1ee0: 00000000 00000000 42166800 00000000 80a00000 80a0307c 80a4cfc1 807defcc
[ 1152.141488] 1f00: 80a03020 80938a30 80a61a80 80a01f3c 80a01f40 80a01f30 80103e68 80103e6c
[ 1152.149660] 1f20: 60000013 ffffffff 00000051 00000000 80a01f4c 80a01f40 806e4680 80103e40
[ 1152.157832] 1f40: 80a01f6c 80a01f50 80141bd0 806e465c 80a0aba8 00000001 ffffffff 80a61a80
[ 1152.166005] 1f60: 80a01f7c 80a01f70 80141edc 80141b4c 80a01f94 80a01f80 806de680 80141ecc
[ 1152.174178] 1f80: 80a61ac8 00000001 80a01fa4 80a01f98 80900ba0 806de610 80a01ff4 80a01fa8
[ 1152.182351] 1fa0: 80901070 80900b94 ffffffff ffffffff 00000000 80900614 00000000 80938a30
[ 1152.190522] 1fc0: df7c7f0f 80a03028 00000000 80900330 00000051 00c0387d 000022b8 9e9fc000
[ 1152.198695] 1fe0: 410fb767 00c5387d 00000000 80a01ff8 00000000 80900c28 00000000 00000000
[ 1152.206855] Backtrace: 
[ 1152.209331] [<804ca76c>] (aspeed_i2c_bus_irq) from [<8014f1a8>] (__handle_irq_event_percpu+0x48/0x1c4)
[ 1152.218643]  r9:00000000 r8:0000002b r7:80a2d90c r6:9e080910 r5:9e0020e0 r4:94cd3940
[ 1152.226391] [<8014f160>] (__handle_irq_event_percpu) from [<8014f360>] (handle_irq_event_percpu+0x3c/0x98)
[ 1152.236041]  r10:80a61a80 r9:80a00000 r8:00000000 r7:80a2d90c r6:9e080910 r5:9e0020e0
[ 1152.243865]  r4:9e11eda0
[ 1152.246405] [<8014f324>] (handle_irq_event_percpu) from [<8014f3f4>] (handle_irq_event+0x38/0x4c)
[ 1152.255274]  r5:9e0020e0 r4:9e11eda0
[ 1152.258865] [<8014f3bc>] (handle_irq_event) from [<80152d48>] (handle_simple_irq+0x90/0xa4)
[ 1152.267209]  r5:9e0020e0 r4:9e11eda0
[ 1152.270815] [<80152cb8>] (handle_simple_irq) from [<8014e44c>] (generic_handle_irq+0x30/0x44)
[ 1152.279333]  r5:9e0020e0 r4:00000005
[ 1152.282949] [<8014e41c>] (generic_handle_irq) from [<803d1a7c>] (aspeed_i2c_ic_irq_handler+0x7c/0x10c)
[ 1152.292269] [<803d1a00>] (aspeed_i2c_ic_irq_handler) from [<8014e44c>] (generic_handle_irq+0x30/0x44)
[ 1152.301491]  r7:9e014600 r6:00000001 r5:80a49edc r4:00000010
[ 1152.307161] [<8014e41c>] (generic_handle_irq) from [<8014eaa4>] (__handle_domain_irq+0x58/0xb4)
[ 1152.315872] [<8014ea4c>] (__handle_domain_irq) from [<801021cc>] (avic_handle_irq+0x68/0x70)
[ 1152.324312]  r9:80a00000 r8:80a03020 r7:80a01f14 r6:ffffffff r5:80a01ee0 r4:9e002e40
[ 1152.332060] [<80102164>] (avic_handle_irq) from [<80101a6c>] (__irq_svc+0x6c/0x90)
[ 1152.339626] Exception stack(0x80a01ee0 to 0x80a01f28)
[ 1152.344687] 1ee0: 00000000 00000000 42166800 00000000 80a00000 80a0307c 80a4cfc1 807defcc
[ 1152.352868] 1f00: 80a03020 80938a30 80a61a80 80a01f3c 80a01f40 80a01f30 80103e68 80103e6c

















At 2023-08-05 18:10:04, "Andi Shyti" <andi.shyti@kernel.org> wrote:
>Hi Lixue,
>
>On Fri, Jul 28, 2023 at 12:24:16PM +0000, Lixue Liang wrote:
>> From: Lixue Liang <lianglixue@greatwall.com.cn>
>> 
>> After waiting for the transmission timeout, the I2C controller will
>> continue to transmit data when the bus is idle. Clearing bus->msg will
>> avoid kernel panic when accessing the freed msg->buf in
>> aspeed_i2c_master_irq.
>
>actually in aspeed_i2c_master_irq() you are already checking for

>!bus->msgs.


Although bus->msgs is not null, but after timeout, call kfree() to 
free bus->msgs[bus->msgs-_index]->buf just like in i2cdev_write.


>
>What kind of panic are you referring to?
>
>Andi
>
>> Signed-off-by: Lixue Liang <lianglixue@greatwall.com.cn>
>> ---
>>  drivers/i2c/busses/i2c-aspeed.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 2e5acfeb76c8..c83057497e26 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -713,6 +713,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
>>  		spin_lock_irqsave(&bus->lock, flags);
>>  		if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
>>  			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
>> +
>> +		bus->msgs = NULL;
>>  		spin_unlock_irqrestore(&bus->lock, flags);
>>  
>>  		return -ETIMEDOUT;
>> -- 
>> 2.27.0
>> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230810/a514f8ae/attachment.htm>
