From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Oct 2020 11:27:43 +0000
Subject: [PATCH 3/3] ARM: dts: add ehci uhci enable in evb dts
In-Reply-To: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
 <20200930040823.26065-4-ryan_chen@aspeedtech.com>
Message-ID: <CACPK8XcmA49S4mJmkmoyTyJ=cWkgyXLrXC-mbWVSO0M_tZAZ1w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2020 at 04:08, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Add EHCI UHCI enable build in aspeed-ast2600-evb.dts
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> index 89be13197780..2772796e215e 100644
> --- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
> @@ -237,3 +237,11 @@
>  &fsim0 {
>         status = "okay";
>  };
> +
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&uhci {
> +       status = "okay";
> +};
> --
> 2.17.1
>
