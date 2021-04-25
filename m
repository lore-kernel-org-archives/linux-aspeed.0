From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 25 Apr 2021 10:32:00 -0700
Subject: [PATCH] pinctrl: aspeed: Fix minor documentation error
In-Reply-To: <1619353584-8196-1-git-send-email-jrdr.linux@gmail.com>
References: <1619353584-8196-1-git-send-email-jrdr.linux@gmail.com>
Message-ID: <6db04e41-3ee6-c569-34b2-83693b620362@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/25/21 5:26 AM, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
> drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c:2705: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c:2614: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> drivers/pinctrl/aspeed/pinctrl-aspeed.c:111: warning: This comment
> starts with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> drivers/pinctrl/aspeed/pinmux-aspeed.c:24: warning: This comment starts
> with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Fix minor documentation error.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 4 ++--
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 4 ++--
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c    | 3 ++-
>  drivers/pinctrl/aspeed/pinmux-aspeed.c     | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> index 996ebcb..4c0d266 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
> @@ -2702,8 +2702,8 @@ static int aspeed_g5_sig_expr_eval(struct aspeed_pinmux_data *ctx,
>  }
>  
>  /**
> - * Configure a pin's signal by applying an expression's descriptor state for
> - * all descriptors in the expression.
> + * aspeed_g5_sig_expr_set() - Configure a pin's signal by applying an
> + * expression's descriptor state for all descriptors in the expression.
>   *
>   * @ctx: The pinmux context
>   * @expr: The expression associated with the function whose signal is to be
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> index 5c1a109..eeab093 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -2611,8 +2611,8 @@
>  };
>  
>  /**
> - * Configure a pin's signal by applying an expression's descriptor state for
> - * all descriptors in the expression.
> + * aspeed_g6_sig_expr_set() - Configure a pin's signal by applying an
> + * expression's descriptor state for all descriptors in the expression.
>   *
>   * @ctx: The pinmux context
>   * @expr: The expression associated with the function whose signal is to be
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index 9c65d56..9bbfe5c 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -108,7 +108,8 @@ static int aspeed_sig_expr_disable(struct aspeed_pinmux_data *ctx,
>  }
>  
>  /**
> - * Disable a signal on a pin by disabling all provided signal expressions.
> + * aspeed_disable_sig() - Disable a signal on a pin by disabling all provided
> + * signal expressions.
>   *
>   * @ctx: The pinmux context
>   * @exprs: The list of signal expressions (from a priority level on a pin)
> diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.c b/drivers/pinctrl/aspeed/pinmux-aspeed.c
> index 57305ca..894e2ef 100644
> --- a/drivers/pinctrl/aspeed/pinmux-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinmux-aspeed.c
> @@ -21,7 +21,8 @@ static inline void aspeed_sig_desc_print_val(
>  }
>  
>  /**
> - * Query the enabled or disabled state of a signal descriptor
> + * aspeed_sig_desc_eval() - Query the enabled or disabled state of a signal
> + * descriptor.
>   *
>   * @desc: The signal descriptor of interest
>   * @enabled: True to query the enabled state, false to query disabled state
> 


-- 
~Randy

