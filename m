From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 30 Jul 2018 16:06:14 -0600
Subject: [PATCH v7 11/12] hwmon: Add PECI dimmtemp driver
In-Reply-To: <20180723214751.1733-12-jae.hyun.yoo@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-12-jae.hyun.yoo@linux.intel.com>
Message-ID: <CAL_JsqK4k=c6k-BJT5fWQH_DCqGhr13fq6M_iZZehaveE-z5Hg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 23, 2018 at 3:49 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds PECI dimmtemp hwmon driver.
>

> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id peci_dimmtemp_of_table[] = {
> +       { .compatible = "intel,peci-dimmtemp" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, peci_dimmtemp_of_table);
> +#endif

This should be removed. Same for cpu temp driver I'm guessing.

Rob
