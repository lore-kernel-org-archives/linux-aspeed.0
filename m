From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 29 Aug 2024 08:23:20 +0200
Subject: [PATCH v2 0/3] Add support for AST2700 clk driver
In-Reply-To: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
Message-ID: <t224vq3mnwwddpmpyi4ajpsippwcj3rc53li6bkccr4s5tf5y7@fjhthwzqhgqy>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2024 at 02:27:37PM +0800, Ryan Chen wrote:
> This patch series is add clk driver for AST2700.
> 
> AST2700 is the 8th generation of Integrated Remote Management Processor
> introduced by ASPEED Technology Inc. Which is Board Management controller
> (BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
> is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.
> 
> v2:
> -yaml: drop 64bits address example.
> -yaml: add discription about soc0 and soc1
> -dt-bindings: remove (), *_NUMS, reserved.
> -dt-bindings: remove dulipated define number
> -clk-ast2700: drop WARN_ON, weird comment.

As LKP pointed out, this fails on certain static tests. It is expected
that new drvier will pass the open/free static analysis tools we use in
the kernel.

Please run standard kernel tools for static analysis, like coccinelle,
smatch and sparse, and fix reported warnings. Also please check for
warnings when building with W=1. Most of these commands (checks or W=1
build) can build specific targets, like some directory, to narrow the
scope to only your code. The code here looks like it needs a fix. Feel
free to get in touch if the warning is not clear.

Best regards,
Krzysztof

