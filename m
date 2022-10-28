From: Lei Yu <yulei.sh@bytedance.com>
Date: Fri, 28 Oct 2022 15:41:53 +0800
Subject: [PATCH] usb: gadget: aspeed: fix buffer overflow
In-Reply-To: <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com> <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 28, 2022 at 2:59 PM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> Thanks for your feedback.
> I tried to reproduce it on my side, and it cannot be reproduce it.
> Here are my test sequences:
> 1. emulate one of the vhub port to usb ethernet through Linux gadget (ncm)

We are using rndis instead of ncm.

> 2. connect BMC vhub to Host
> 3. BMC & Host can ping each other (both usb eth dev default mtu is 1500)
> 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu to 2000, it's maxmtu is 1500)

Not sure if it's related, but in my case (USB rndis, Debian 10 OS) it
should be able to set MTU to 2000.

> 5. ping BMC with `s -1500` argument from Host OS
> 6. BMC kernel no oops
>
> I dumped the `req` related members in ast_vhub_epn_handle_ack() to see if whether the received data length exceeds the buffer length.
> In my case `req.length` is 16384 bytes, so it never exceeds it in this case.
> I'm wondering what's the value of `req.length` in your test scenario? And how can I reproduce it?

The last 3 calls of ast_vhub_epn_handle_ack():

ast_vhub_epn_handle_ack?req->last_desc=-1
req.actual=1024,req.length=1578,ep->ep.maxpacket=512
ast_vhub_epn_handle_ack?req->last_desc=-1
req.actual=1536,req.length=1578,ep->ep.maxpacket=512
ast_vhub_epn_handle_ack?req->last_desc=1
req.actual=1634,req.length=1578,ep->ep.maxpacket=512

We can see the last packet 1634 exceeds the req.legnth 1578, and
that's when the buffer overflow occurs.
