From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Oct 2020 11:22:41 +0000
Subject: [PATCH 1/3] configs: aspeed: enable UHCI driver in defconfig
In-Reply-To: <20200930040823.26065-2-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-2-ryan_chen@aspeedtech.com>
Message-ID: <CACPK8XfBQgFk8oCaN_YAoKrvmV7QaOTFrHCWcjpEQv3bbjm70w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Enable UHCI driver in aspeed_g5_defconfig.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <Joel@jms.id.au>

> ---
>  arch/arm/configs/aspeed_g5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 2bacd8c90f4b..a57009d1a3b8 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -212,6 +212,7 @@ CONFIG_USB_DYNAMIC_MINORS=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_ROOT_HUB_TT=y
>  CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_UHCI_HCD=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_ASPEED_VHUB=y
>  CONFIG_USB_CONFIGFS=y
> --
> 2.17.1
>
