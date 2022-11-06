From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun, 6 Nov 2022 01:23:55 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
In-Reply-To: <20221105013321.2719-3-zev@bewilderbeest.net>
References: <20221105013321.2719-1-zev@bewilderbeest.net>
 <20221105013321.2719-3-zev@bewilderbeest.net>
Message-ID: <Y2d9K1KGM8BcR6Rn@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 04, 2022 at 06:33:21PM PDT, Zev Weiss wrote:
>This is a 1U Open19 power shelf with six PSUs and 50 12VDC outputs via
>LM25066 efuses.  It's managed by a pair of AST1250 BMCs in a redundant
>active/active configuration using a PCA9541 on each I2C bus to
>arbitrate access between the two.
>
>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>---
> arch/arm/boot/dts/Makefile                    |    1 +
> .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 1094 +++++++++++++++++
> 2 files changed, 1095 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
>

Hmm -- actually, after posting this I realized that the repetitive efuse 
nodes could be expressed in a much more concise and much less tedious, 
error-prone manner using a preprocessor macro or two; I'll send a v2 
with that approach instead.


Zev

