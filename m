From: Joel Stanley <joel@jms.id.au>
Date: Mon, 29 Apr 2019 06:34:28 +0000
Subject: [PATCH] misc: aspeed-p2a-ctrl: fix mixed declarations
In-Reply-To: <20190426165655.218228-1-venture@google.com>
References: <20190426165655.218228-1-venture@google.com>
Message-ID: <CACPK8XcbSZCpR5tjAXTSuvhfTyeQ_dJTTDOqZVVP=VWCxkaV6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2019 at 16:57, Patrick Venture <venture@google.com> wrote:
>
> Fix up mixed declarations and code in aspeed_p2a_mmap.
>
> Tested: Verified the build had the error and that this patch resolved it
> and there were no other warnings or build errors associated with
> compilation of this driver.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Patrick Venture <venture@google.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/misc/aspeed-p2a-ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/aspeed-p2a-ctrl.c b/drivers/misc/aspeed-p2a-ctrl.c
> index 9736821972ef..b60fbeaffcbd 100644
> --- a/drivers/misc/aspeed-p2a-ctrl.c
> +++ b/drivers/misc/aspeed-p2a-ctrl.c
> @@ -100,6 +100,7 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
>  static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>         unsigned long vsize;
> +       pgprot_t prot;
>         struct aspeed_p2a_user *priv = file->private_data;
>         struct aspeed_p2a_ctrl *ctrl = priv->parent;
>
> @@ -107,7 +108,7 @@ static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
>                 return -EINVAL;
>
>         vsize = vma->vm_end - vma->vm_start;
> -       pgprot_t prot = vma->vm_page_prot;
> +       prot = vma->vm_page_prot;
>
>         if (vma->vm_pgoff + vsize > ctrl->mem_base + ctrl->mem_size)
>                 return -EINVAL;
> --
> 2.21.0.593.g511ec345e18-goog
>
