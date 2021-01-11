From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 11 Jan 2021 15:58:59 -0500
Subject: [Aspeed, ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue
In-Reply-To: <20201215192323.24359-1-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
Message-ID: <20210111205900.22589-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> Hi Hongwei,
> 
> The NCSI should run on 3.3V RMII.  According your log, you enabled NCSI on 
> ftgmac100 at 1e660000 which can only support 1.8V I/O voltage.
> Did you observe the same error on ftgmac100 at 1e670000 (MAC3) or ftgmac100 at 1e690000 (MAC4)?
> 

Hi Dylan,

Thanks for your review and input, you're correct, this issue is not observed on
AST2600 MAC4 (ftgmac100 at 1e690000).

Though this issue is caused by using NCSI incompatible MAC ftgmac100 at 1e660000,
we thought this patch is still having value, by providing an extra option to
user to be able to use ftgmac100 at 1e660000 for NCSI, and this is also true for
AST2500.

--Hongwei
 
> > -----Original Message-----
> > From: Linux-aspeed
> > [mailto:linux-aspeed-bounces+dylan_hung=aspeedtech.com at lists.ozlabs.or
> > g]
> > On Behalf Of Joel Stanley
> > Sent: 2020?12?22? 10:26 AM
> > To: Hongwei Zhang <hongweiz@ami.com>; Ryan Chen 
> > <ryan_chen@aspeedtech.com>
> > Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>; netdev 
> > <netdev@vger.kernel.org>; OpenBMC Maillist <openbmc@lists.ozlabs.org>; 
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Jakub 
> > Kicinski <kuba@kernel.org>; David S Miller <davem@davemloft.net>
> > Subject: Re: [Aspeed, ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB 
> > NCSI RX issue
> > 
> > On Mon, 21 Dec 2020 at 17:01, Hongwei Zhang <hongweiz@ami.com> wrote:
> > >
> > > Dear Reviewer,
> > >
> > > When FTGMAC100 driver is used on other NCSI Ethernet controllers, 
> > > few controllers have compatible issue. One example is Intel I210 
> > > Ethernet controller on AST2600 BMC, with FTGMAC100 driver, it always 
> > > trigger RXDES0_RX_ERR error, cause NCSI initialization failure, 
> > > removing FTGMAC100_RXDES0_RX_ERR bit from RXDES0_ANY_ERROR fix the issue.
> > 
> > I work with a few systems that use the i210 on the 2600. We haven't 
> > seen this issue in our testing.
> > 
> > Is there something specific about the setup that you use to trigger this?
> > 
> > Ryan, is this an issue that Aspeed is aware of?
> > 
> > Cheers,
> > 
> > Joel

Hello Joel,

Thanks for your review, please see my response to Dylan, he pointed out
the root cause of the issue.

-- Hongwei

> > 
> > >
> > > Here are part of the debug logs:
> > > ......
> > > [   35.075552] ftgmac100_hard_start_xmit TXDESO=b000003c
> > > [   35.080843] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 55
> > > [   35.087141] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> > RXDES0=0xb0070040
> > > [   37.067831] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> > > ............
> > >
> > > This patch add a configurable flag, FTGMAC100_RXDES0_RX_ERR_CHK, in
> > > FTGMAC100  driver, it is YES by default, so keep the orignal define 
> > > of RXDES0_ANY_ERROR. If it is needed, user can set the flag to NO to 
> > > remove the RXDES0_RX_ERR bit, to fix the issue.
> > >
> > > Hongwei Zhang (1):
> > >   net: ftgmac100: Fix AST2600 EVB NCSI RX issue
> > >
> > >  drivers/net/ethernet/faraday/Kconfig     | 9 +++++++++
> > >  drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > --
> > > 2.17.1
> > >
> 
