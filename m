From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 11 Jan 2021 15:59:00 -0500
Subject: [Aspeed, ncsi-rx, v2 1/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue
In-Reply-To: <20201215192323.24359-1-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
Message-ID: <20210111205900.22589-2-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> From:	Jakub Kicinski <kuba@kernel.org>
> Sent:	Monday, December 21, 2020 5:10 PM
> To:	Hongwei Zhang
> 
> On Mon, 21 Dec 2020 14:40:26 -0500 Hongwei Zhang wrote:
> > When FTGMAC100 driver is used on other NCSI Ethernet controllers, few
> 
> When you say NCSI Ethernet controller here you mean the main system NIC, right? The MAC on the NCSI 
> side is FTGMAC100, correct?
> 

Hi Jakub,

The use case for us is the MAC is configured as NCSI, so it provides network
 access for both BMC and Host, the Ethernet controller driver is from BMC kernel
side.

please see my response to Dylan in another thread, <20201215192323.24359-1-hongweiz@ami.com>,
he points out the root cause of the issue.

> In that case I'm not sure how user is supposed to control this setting at build time. The system NIC is 
> often pluggable on the PCIe bus, and can be changed at will.
> 
> > controllers have compatible issue, removing FTGMAC100_RXDES0_RX_ERR 
> > bit from RXDES0_ANY_ERROR can fix the issue.
> > 
> > Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
> 
> Please fix the commit hash, this hash does not exist upstream:
> 

will do.

Thanks
--Hongwei

> Commit: 8711d4ef64fa ("net: ftgmac100: Fix AST2600 EVB NCSI RX issue")
> 	Fixes tag: Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> 
