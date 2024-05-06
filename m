From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 06 May 2024 21:46:50 +0800
Subject: [PATCH 0/2] [RFC] i3c: ast2600: Add MCTP-over-I3C support
In-Reply-To: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
References: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
Message-ID: <42ec2da02cc1260fd1c05bdeb620f770c8ecc767.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dylan,

> Add Aspeed AST2600 I3C controllers and add minimal changes to
> validate
> the functionality for MCTP-over-I3C.
> 
> Dylan Hung (2):
> ? [RFC] ARM: dts: aspeed-g6: Add AST2600 I3Cs

I'd sent a similar patch earlier:

  https://lists.ozlabs.org/pipermail/linux-aspeed/2024-May/012193.html

And a v2 to account for some feedback on the dts layout:

  https://lists.ozlabs.org/pipermail/linux-aspeed/2024-May/012213.html

> ? [RFC] i3c: ast2600: Validate AST2600 I3C for MCTP-over-I3C

Looks interesting, I'll check this out soon.

Cheers,


Jeremy
