From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Aug 2024 06:48:26 -0600
Subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
In-Reply-To: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com> <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CAL_JsqKtuuOyRu+fQ6Yu=7QHMWN+qPwwUYmuuEufYNtyyTw81Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Aug 16, 2024 at 3:26?AM Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Fix GPIO linename typo and add missing GPIO pin initial state.
>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
>  1 file changed, 455 insertions(+), 99 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index abd4a9173de4..4090725160f9 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -285,6 +285,8 @@ &mac2 {
>         pinctrl-0 = <&pinctrl_rmii3_default>;
>         use-ncsi;
>         mellanox,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;

Not a vendor prefix nor a documented property name.

Rob
