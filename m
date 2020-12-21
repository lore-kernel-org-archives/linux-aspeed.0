From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 21 Dec 2020 12:00:47 -0500
Subject: [Aspeed, ncsi-rx, v1 0/1] net: ftgmac100: Fix AST2600EVB NCSI RX issue
In-Reply-To: <20201215192323.24359-1-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
Message-ID: <20201221170048.29821-3-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

> From:	Andrew Jeffery <andrew@aj.id.au>
> 
> > Fix AST2600 EVB NCSI RX timeout issue by removing 
> > FTGMAC100_RXDES0_RX_ERR bit from macro RXDES0_ANY_ERROR.
> 
> But why? What is wrong with the EVB that this change resolves? Which revision of the EVB?
> 
> The change affects all designs using the MAC, not just the AST2600 EVB. Why is this patch an 
> appropriate course of action? Can we not add a quirk targeting the specific board (e.g. a devicetree 
> property)?

You are correct. I was in a rush and didn't put this patch under whole picture 
of the driver it affected. I revised the cover letter with more information, also
use a configurable flag to isolate the change. please review the new approach.

> 
> Andrew
> 
Thanks,
--Hongwei

