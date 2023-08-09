From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 09 Aug 2023 08:28:57 +0800
Subject: [PATCH 0/3] Add Aspeed AST2600 I3C support
In-Reply-To: <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
	 <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
Message-ID: <a670192024911f7f2d676e245f5f240e9ed5126b.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dylan,

> - with no changes needed to any bindings. I haven't needed any other
> resets; are there per-controller resets specified in the HW docs you
> have?

... keeping in mind the reset control that the aspeed SCU driver
already provides for you, when you enable the appropriate clock gate:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-aspeed.c#n224

Cheers,


Jeremy
