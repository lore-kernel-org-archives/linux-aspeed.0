From: Conor Dooley <conor@kernel.org>
Date: Tue, 13 Feb 2024 20:27:06 -0000
Subject: [PATCH 0/6] dts: Fix dtc interrupt warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Message-ID: <20240213-wafer-garnish-88287bc5d4a5@spud>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 13, 2024 at 01:34:24PM -0600, Rob Herring wrote:
> I had a branch with most of these changes sitting in my tree for some 
> time. Geert's asking about some errors not getting found prompted me to 
> clean it up and send it out. This series fixes all* interrupt related 
> warnings and enables the check by default. 
> 
> SoC maintainers, Can you please take this series directly. 
> 
> Rob
> 
> *There's a few Renesas warnings still Geert said he would fix.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Rob Herring (6):
>       arm64: dts: freescale: Disable interrupt_map check
>       arm: dts: Fix dtc interrupt_provider warnings
>       arm64: dts: Fix dtc interrupt_provider warnings
>       arm: dts: Fix dtc interrupt_map warnings
>       arm64: dts: qcom: Fix interrupt-map cell sizes
>       dtc: Enable dtc interrupt_provider check

Only fixing it for arm, Sadge.

Co-incidentally I noticed there was one for riscv while looking at
Krzysztof's underscore in node name patch earlier, so I'd already
written a patch to fix it :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240213/3b535fde/attachment-0001.sig>
