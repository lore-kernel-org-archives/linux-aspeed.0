From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 16 Dec 2020 09:17:36 +1030
Subject: =?UTF-8?Q?Re:_[Aspeed, ncsi-rx,
 _v1_1/1]_net:_ftgmac100:_Fix_AST2600_EVB_N?= =?UTF-8?Q?CSI_RX_issue?=
In-Reply-To: <20201215192323.24359-2-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
 <20201215192323.24359-2-hongweiz@ami.com>
Message-ID: <0a513b26-a4e4-4808-a02a-eb6ffc84f5ba@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 16 Dec 2020, at 05:53, Hongwei Zhang wrote:
> Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit
> from macro RXDES0_ANY_ERROR.

But why? What is wrong with the EVB that this change resolves? Which revision 
of the EVB?

The change affects all designs using the MAC, not just the AST2600 EVB. Why is 
this patch an appropriate course of action? Can we not add a quirk targeting the
specific board (e.g. a devicetree property)?

Andrew
