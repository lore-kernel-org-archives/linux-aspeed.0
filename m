From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Apr 2020 23:18:38 +0000
Subject: [PATCH] ipmi: kcs: Fix aspeed_kcs_probe_of_v1()
In-Reply-To: <20200407122149.GA100026@mwanda>
References: <20200407122149.GA100026@mwanda>
Message-ID: <CACPK8XfA-4WvgVeEKi-hdC-LgEcicEhpV_0ivwymaEJKy15hGA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2020 at 12:22, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This needs to return the newly allocated struct but instead it returns
> zero which leads to an immediate Oops in the caller.
>
> Fixes: 09f5f680707e ("ipmi: kcs: aspeed: Implement v2 bindings")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the fix Dan.

Andrew, I think this means no one has used the v1 bindings in
mainline, so could remove that code?

> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 9422d55a0476..a140203c079b 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -271,7 +271,7 @@ static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
>         kcs->ioreg = ast_kcs_bmc_ioregs[channel - 1];
>         aspeed_kcs_set_address(kcs, slave);
>
> -       return 0;
> +       return kcs;
>  }
>
>  static int aspeed_kcs_calculate_channel(const struct kcs_ioreg *regs)
> --
> 2.25.1
>
