From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 22 Dec 2020 02:43:39 +0000
Subject: [Aspeed, ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX
 issue
In-Reply-To: <CACPK8Xe8_S6jgs-DxpB0Veu=25JXftTLeK7nGhLJ51GghSeVHw@mail.gmail.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
 <20201221170048.29821-1-hongweiz@ami.com>
 <CACPK8Xe8_S6jgs-DxpB0Veu=25JXftTLeK7nGhLJ51GghSeVHw@mail.gmail.com>
Message-ID: <HK0PR06MB2834133F49A2093B163139519CDF0@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Hongwei,

The NCSI should run on 3.3V RMII.  According your log, you enabled NCSI on ftgmac100 at 1e660000 which can only support 1.8V I/O voltage.
Did you observe the same error on ftgmac100 at 1e670000 (MAC3) or ftgmac100 at 1e690000 (MAC4)?

--
Dylan

> -----Original Message-----
> From: Linux-aspeed
> [mailto:linux-aspeed-bounces+dylan_hung=aspeedtech.com at lists.ozlabs.org]
> On Behalf Of Joel Stanley
> Sent: 2020?12?22? 10:26 AM
> To: Hongwei Zhang <hongweiz@ami.com>; Ryan Chen
> <ryan_chen@aspeedtech.com>
> Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>; netdev
> <netdev@vger.kernel.org>; OpenBMC Maillist <openbmc@lists.ozlabs.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Jakub Kicinski
> <kuba@kernel.org>; David S Miller <davem@davemloft.net>
> Subject: Re: [Aspeed, ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX
> issue
> 
> On Mon, 21 Dec 2020 at 17:01, Hongwei Zhang <hongweiz@ami.com> wrote:
> >
> > Dear Reviewer,
> >
> > When FTGMAC100 driver is used on other NCSI Ethernet controllers, few
> > controllers have compatible issue. One example is Intel I210 Ethernet
> > controller on AST2600 BMC, with FTGMAC100 driver, it always trigger
> > RXDES0_RX_ERR error, cause NCSI initialization failure, removing
> > FTGMAC100_RXDES0_RX_ERR bit from RXDES0_ANY_ERROR fix the issue.
> 
> I work with a few systems that use the i210 on the 2600. We haven't seen this
> issue in our testing.
> 
> Is there something specific about the setup that you use to trigger this?
> 
> Ryan, is this an issue that Aspeed is aware of?
> 
> Cheers,
> 
> Joel
> 
> >
> > Here are part of the debug logs:
> > ......
> > [   35.075552] ftgmac100_hard_start_xmit TXDESO=b000003c
> > [   35.080843] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 55
> > [   35.087141] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> RXDES0=0xb0070040
> > [   35.094448] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000
> RXDES2=88f8
> > [   35.101498] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> 0xb0070040
> > [   35.108205] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040:
> RX_ERR
> > [   35.287808] i2c i2c-1: new_device: Instantiated device slave-mqueue at
> 0x12
> > [   35.428379] ftgmac100_hard_start_xmit TXDESO=b000003c
> > [   35.433624] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 56
> > [   35.439915] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> RXDES0=0xb0070040
> > [   35.447225] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000
> RXDES2=88f8
> > [   35.454273] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> 0xb0070040
> > [   35.460972] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040:
> RX_ERR
> > [   35.797825] ftgmac100_hard_start_xmit TXDESO=b000003c
> > [   35.803241] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 57
> > [   35.809541] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> RXDES0=0xb0070040
> > [   35.816848] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000
> RXDES2=88f8
> > [   35.823899] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> 0xb0070040
> > [   35.830597] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040:
> RX_ERR
> > [   36.179914] ftgmac100_hard_start_xmit TXDESO=b000003c
> > [   36.185160] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 58
> > [   36.191454] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> RXDES0=0xb0070040
> > [   36.198761] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000
> RXDES2=88f8
> > [   36.205813] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> 0xb0070040
> > [   36.212513] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040:
> RX_ERR
> > [   36.593688] ftgmac100_hard_start_xmit TXDESO=b000003c
> > [   36.602937] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 59
> > [   36.609244] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> RXDES0=0xb0070040
> > [   36.616558] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000
> RXDES2=88f8
> > [   36.623608] ftgmac100 1e660000.ethernet eth0: rx_packet_error
> 0xb0070040
> > [   36.630315] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040:
> RX_ERR
> > [   37.031524] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> > [   37.067831] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> > ............
> >
> > This patch add a configurable flag, FTGMAC100_RXDES0_RX_ERR_CHK, in
> > FTGMAC100  driver, it is YES by default, so keep the orignal define of
> > RXDES0_ANY_ERROR. If it is needed, user can set the flag to NO to
> > remove the RXDES0_RX_ERR bit, to fix the issue.
> >
> > Hongwei Zhang (1):
> >   net: ftgmac100: Fix AST2600 EVB NCSI RX issue
> >
> >  drivers/net/ethernet/faraday/Kconfig     | 9 +++++++++
> >  drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
> >  2 files changed, 17 insertions(+)
> >
> > --
> > 2.17.1
> >
