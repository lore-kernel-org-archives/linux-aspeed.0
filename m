From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 21 Dec 2020 14:40:25 -0500
Subject: [Aspeed, ncsi-rx,
 v2 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue 
In-Reply-To: <20201215192323.24359-1-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
Message-ID: <20201221194026.30715-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

When FTGMAC100 driver is used on other NCSI Ethernet controllers, few
controllers have compatible issue. One example is Intel I210 Ethernet
controller on AST2600 BMC, with FTGMAC100 driver, it always trigger
RXDES0_RX_ERR error, cause NCSI initialization failure, removing
FTGMAC100_RXDES0_RX_ERR bit from RXDES0_ANY_ERROR fix the issue.

Here are part of the debug logs:
......
[   35.075552] ftgmac100_hard_start_xmit TXDESO=b000003c
[   35.080843] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 55
[   35.087141] ftgmac100 1e660000.ethernet eth0: rx_packet_error RXDES0=0xb0070040
[   35.094448] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000 RXDES2=88f8 
[   35.101498] ftgmac100 1e660000.ethernet eth0: rx_packet_error 0xb0070040
[   35.108205] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040: RX_ERR
[   35.287808] i2c i2c-1: new_device: Instantiated device slave-mqueue at 0x12
[   35.428379] ftgmac100_hard_start_xmit TXDESO=b000003c
[   35.433624] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 56
[   35.439915] ftgmac100 1e660000.ethernet eth0: rx_packet_error RXDES0=0xb0070040
[   35.447225] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000 RXDES2=88f8
[   35.454273] ftgmac100 1e660000.ethernet eth0: rx_packet_error 0xb0070040
[   35.460972] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040: RX_ERR
[   35.797825] ftgmac100_hard_start_xmit TXDESO=b000003c
[   35.803241] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 57
[   35.809541] ftgmac100 1e660000.ethernet eth0: rx_packet_error RXDES0=0xb0070040
[   35.816848] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000 RXDES2=88f8
[   35.823899] ftgmac100 1e660000.ethernet eth0: rx_packet_error 0xb0070040
[   35.830597] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040: RX_ERR
[   36.179914] ftgmac100_hard_start_xmit TXDESO=b000003c
[   36.185160] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 58
[   36.191454] ftgmac100 1e660000.ethernet eth0: rx_packet_error RXDES0=0xb0070040
[   36.198761] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000 RXDES2=88f8
[   36.205813] ftgmac100 1e660000.ethernet eth0: rx_packet_error 0xb0070040
[   36.212513] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040: RX_ERR
[   36.593688] ftgmac100_hard_start_xmit TXDESO=b000003c
[   36.602937] ftgmac100 1e660000.ethernet eth0: tx_complete_packet 59
[   36.609244] ftgmac100 1e660000.ethernet eth0: rx_packet_error RXDES0=0xb0070040
[   36.616558] ftgmac100_rx_packet RXDES0=b0070040 RXDES1=f0800000 RXDES2=88f8
[   36.623608] ftgmac100 1e660000.ethernet eth0: rx_packet_error 0xb0070040
[   36.630315] ftgmac100 1e660000.ethernet eth0: [ISR] = 0xb0070040: RX_ERR
[   37.031524] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   37.067831] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
............

This patch add a configurable flag, FTGMAC100_RXDES0_RX_ERR_CHK, in FTGMAC100
 driver, it is YES by default, so keep the orignal define of
RXDES0_ANY_ERROR. If it is needed, user can set the flag to NO to remove
the RXDES0_RX_ERR bit, to fix the issue.

Hongwei Zhang (1):
  net: ftgmac100: Fix AST2600 EVB NCSI RX issue

 drivers/net/ethernet/faraday/Kconfig     | 9 +++++++++
 drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
 2 files changed, 17 insertions(+)

-- 
2.17.1

