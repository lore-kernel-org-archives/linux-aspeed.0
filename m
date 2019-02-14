From: Joel Stanley <joel@jms.id.au>
Date: Thu, 14 Feb 2019 13:15:51 +1030
Subject: [PATCH] ARM:dts:aspeed Add Inspur on5263m5 BMC
In-Reply-To: <4C4C6975-CA11-4609-BF8D-6246A1C5F193@fb.com>
References: <1547708191-8721-1-git-send-email-wangzqbj@inspur.com>
 <4C4C6975-CA11-4609-BF8D-6246A1C5F193@fb.com>
Message-ID: <CACPK8XdFPLdGJw2RM3r55wX=8U1UgLNN_kk-9jBZenMF6ezSpg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 13 Feb 2019 at 08:40, Vijay Khemka <vijaykhemka@fb.com> wrote:

> ?On 2/12/19, 1:58 PM, "Linux-aspeed on behalf of John Wang" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of wangzqbj@inspur.com> wrote:
>
>     Add initial version of device tree file for on5263m5 ast2500bmc
>
>     Signed-off-by: John Wang <wangzqbj@inspur.com>
>     ---
>      arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts | 146 +++++++++++++++++++++++
>      1 file changed, 146 insertions(+)
>      create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts

>     +&pinctrl {
>     +   aspeed,external-nodes = <&gfx &lhc>;
>     +};
> This pinctrl definition is not required as it is already defined in aspeed-g5.dtsi.

I've already applied the patch and sent the pull request. Please
follow up with a patch to clean this up.

Cheers,

Joel
