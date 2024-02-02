From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 2 Feb 2024 20:20:48 +0100
Subject: [PATCH AUTOSEL 6.7 20/23] ARM: dts: Fix TPM schema violations
In-Reply-To: <20240202183926.540467-20-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
 <20240202183926.540467-20-sashal@kernel.org>
Message-ID: <20240202192048.GA22666@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sasha,

On Fri, Feb 02, 2024 at 01:39:16PM -0500, Sasha Levin wrote:
> [ Upstream commit 8412c47d68436b9f9a260039a4a773daa6824925 ]
> 
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for ARM
> devicetrees:

You've auto-selected this commit for backporting to v6.6 and v6.7
stable kernels, but it's only really needed for v6.8 to avoid
issues reported by "make dtbs_check".

So IMO this commit can be dropped from the v6.6 and v6.7 patch queues.

Thanks,

Lukas

> The nodename needs to be "tpm at 0" rather than "tpmdev at 0" and the
> compatible property needs to contain the chip's name in addition to the
> generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c":
> 
>   tpmdev at 0: $nodename:0: 'tpmdev at 0' does not match '^tpm(@[0-9a-f]+)?$'
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> 
>   tpm at 2e: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['tcg,tpm-tis-i2c'] is too short
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2c.yaml#
> 
> Fix these schema violations.
