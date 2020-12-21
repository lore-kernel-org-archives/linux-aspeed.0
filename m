From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 21 Dec 2020 14:09:59 -0800
Subject: [Aspeed,ncsi-rx, v2 1/1] net: ftgmac100: Fix AST2600 EVB NCSI
 RX issue
In-Reply-To: <20201221194026.30715-2-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
 <20201221194026.30715-2-hongweiz@ami.com>
Message-ID: <20201221140959.793449e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 21 Dec 2020 14:40:26 -0500 Hongwei Zhang wrote:
> When FTGMAC100 driver is used on other NCSI Ethernet controllers, few

When you say NCSI Ethernet controller here you mean the main system
NIC, right? The MAC on the NCSI side is FTGMAC100, correct?

In that case I'm not sure how user is supposed to control this setting
at build time. The system NIC is often pluggable on the PCIe bus, and
can be changed at will.

> controllers have compatible issue, removing FTGMAC100_RXDES0_RX_ERR bit
> from RXDES0_ANY_ERROR can fix the issue.
> 
> Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")

Please fix the commit hash, this hash does not exist upstream:

Commit: 8711d4ef64fa ("net: ftgmac100: Fix AST2600 EVB NCSI RX issue")
	Fixes tag: Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
	Has these problem(s):
		- Target SHA1 does not exist

> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> ---
>  drivers/net/ethernet/faraday/Kconfig     | 9 +++++++++
>  drivers/net/ethernet/faraday/ftgmac100.h | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
> index c2677ec0564d..ccd0c30be0db 100644
> --- a/drivers/net/ethernet/faraday/Kconfig
> +++ b/drivers/net/ethernet/faraday/Kconfig
> @@ -38,4 +38,13 @@ config FTGMAC100
>  	  from Faraday. It is used on Faraday A369, Andes AG102 and some
>  	  other ARM/NDS32 SoC's.
>  
> +config FTGMAC100_RXDES0_RX_ERR_CHK
> +	bool "Include FTGMAC100_RXDES0_RX_ERR in RXDES0_ANY_ERROR"
> +	default y
> +	depends on FTGMAC100
> +	help
> +	  Say N here if the NCSI controller on your platform has compatible
> +	  issue with FTGMAC100, thus always trigger RXDES0_RX_ERR. Exclude
> +	  this bit can fix the issue.
> +
>  endif # NET_VENDOR_FARADAY
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 63b3e02fab16..59e1bd52d261 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h
> @@ -251,12 +251,20 @@ struct ftgmac100_rxdes {
>  #define FTGMAC100_RXDES0_RXPKT_RDY	(1 << 31)
>  
>  /* Errors we care about for dropping packets */
> +#ifdef CONFIG_FTGMAC100_RXDES0_RX_ERR_CHK
>  #define RXDES0_ANY_ERROR		( \
>  	FTGMAC100_RXDES0_RX_ERR		| \
>  	FTGMAC100_RXDES0_CRC_ERR	| \
>  	FTGMAC100_RXDES0_FTL		| \
>  	FTGMAC100_RXDES0_RUNT		| \
>  	FTGMAC100_RXDES0_RX_ODD_NB)
> +#else
> +#define RXDES0_ANY_ERROR		( \
> +	FTGMAC100_RXDES0_CRC_ERR	| \
> +	FTGMAC100_RXDES0_FTL		| \
> +	FTGMAC100_RXDES0_RUNT		| \
> +	FTGMAC100_RXDES0_RX_ODD_NB)
> +#endif
>  
>  #define FTGMAC100_RXDES1_VLANTAG_CI	0xffff
>  #define FTGMAC100_RXDES1_PROT_MASK	(0x3 << 20)

