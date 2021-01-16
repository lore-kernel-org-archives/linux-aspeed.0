From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Sat, 16 Jan 2021 01:03:11 +0000
Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
In-Reply-To: <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
 <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CAK8P3a2WPvWokkqJB-yhfQH1ofofGNvibqPjUXPme+F2LCHjxw@mail.gmail.com>
Message-ID: <HK0PR06MB3380A1F79CDE49FACC1A3E71F2A60@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Saturday, January 16, 2021 1:05 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: John Wang <wangzhiqiang.bj@bytedance.com>;
> xuxiaohan at bytedance.com; yulei.sh at bytedance.com; Robert Lippert
> <rlippert@google.com>; moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-aspeed@lists.ozlabs.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Vernon Mauery
> <vernon.mauery@linux.intel.com>; open list <linux-kernel@vger.kernel.org>;
> Jae Hyun Yoo <jae.hyun.yoo@intel.com>; Patrick Venture
> <venture@google.com>; moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
> SNOOP driver
> 
> On Wed, Jan 6, 2021 at 10:57 AM Ryan Chen <ryan_chen@aspeedtech.com>
> wrote:
> >
> > Hello John, Joel, Jae,
> >         For this should be set LCLK to be CRITICAL it will fix LPC related
> driver. (KCS/BT/SNOOP)
> >         I have send the patch before.
> >
> > https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108
> > .14040-2-ryan_chen at aspeedtech.com/
> >
> > Hello Joel,
> >         Will you consider this patch?
> >         Beside KCS/BT/SNOOP, UART1/UART2 will be most related issue
> for host side.
> 
> Sorry it did not make it into the merge window. The patch is still in patchwork.
> I could just pick it up directly for v5.12, or wait for a combined pull request
> with other work. 

Hello Arnd,
Thanks your update.

>Joel, please let me know what you prefer.
> 
Hello Joel,
Could you help check on this patch? 
https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen at aspeedtech.com/
