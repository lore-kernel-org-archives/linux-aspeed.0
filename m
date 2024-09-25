From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 25 Sep 2024 10:14:58 +0930
Subject: [PATCH v1 0/3] Revise Meta (Facebook) Minerva BMC (AST2600)
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Message-ID: <172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 22:02:12 +0800, Yang Chen wrote:
> Revise linux device tree entry related to Meta (Facebook) Minerva specific
> devices connected to BMC (AST2600) SoC.
> 
> Yang Chen (3):
>   ARM: dts: aspeed: minerva: Revise the SGPIO line name
>   ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
>   ARM: dts: aspeed: minerva: add fru device for other blades
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>

