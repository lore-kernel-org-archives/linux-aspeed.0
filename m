From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 28 Oct 2022 06:59:31 +0000
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <20221024094853.2877441-1-yulei.sh@bytedance.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
Message-ID: <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Henry Tian <tianxiaofeng@bytedance.com>
> 
> In ast_vhub_epn_handle_ack() when the received data length exceeds the
> buffer, it does not check the case and just copies to req.buf and cause a buffer
> overflow, kernel oops on this case.
> 
> This issue could be reproduced on a BMC with an OS that enables the lan over
> USB:
> 1. In OS, enable the usb eth dev, verify it pings the BMC OK; 2. In OS, set the
> usb dev mtu to 2000. (Default is 1500); 3. In OS, ping the BMC with `-s 2000`
> argument.
> 
> The BMC kernel will get oops with below logs:
> 
>     skbuff: skb_over_panic: text:8058e098 len:2048 put:2048
> head:84c678a0 data:84c678c2 tail:0x84c680c2 end:0x84c67f00 dev:usb0
>     ------------[ cut here ]------------
>     kernel BUG at net/core/skbuff.c:113!
>     Internal error: Oops - BUG: 0 [#1] ARM
>     CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.15.69-c9fb275-dirty-d1e579a #1
>     Hardware name: Generic DT based system
>     PC is at skb_panic+0x60/0x6c
>     LR is at irq_work_queue+0x6c/0x94
> 
> Fix the issue by checking the length and set `-EOVERFLOW`.
> 
> Tested: Verify the BMC kernel does not get oops in the above case, and the usb
> ethernet gets RX packets errors instead.

Thanks for your feedback.
I tried to reproduce it on my side, and it cannot be reproduce it.
Here are my test sequences:
1. emulate one of the vhub port to usb ethernet through Linux gadget (ncm)
2. connect BMC vhub to Host
3. BMC & Host can ping each other (both usb eth dev default mtu is 1500)
4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu to 2000, it's maxmtu is 1500)
5. ping BMC with `s -1500` argument from Host OS
6. BMC kernel no oops

I dumped the `req` related members in ast_vhub_epn_handle_ack() to see if whether the received data length exceeds the buffer length.
In my case `req.length` is 16384 bytes, so it never exceeds it in this case.
I'm wondering what's the value of `req.length` in your test scenario? And how can I reproduce it?
Thanks

