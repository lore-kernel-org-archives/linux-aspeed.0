From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 May 2021 07:55:41 +0000
Subject: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus
 signal
In-Reply-To: <20210524073308.9328-1-steven_lee@aspeedtech.com>
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
Message-ID: <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 24 May 2021 at 07:33, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST2600-A2 EVB has the reference design for enabling SD bus
> power and toggling SD bus signal voltage between 3.3v and 1.8v by
> GPIO regulators.
> This patch series adds sdhci node and gpio regulators in a new dts file
> for AST2600-A2 EVB.
> The description of the reference design of AST2600-A2 EVB is added
> in the new dts file.
>
> This patch also include a helper for updating AST2600 sdhci capability
> registers.

The device trees look good:

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've applied patches 1-3 to the aspeed tree for v5.14. I made a little
fix to patch 3 as it needed to add the new device tree to the
makefile.

When I was testing on my A2 EVB I saw this:

[    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
clamping to tap 15
[    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
clamping to tap 15

Do you know what is happening there?

Cheers,

Joel
