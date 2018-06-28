From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 13:40:48 +0930
Subject: [PATCH 03/14] fsi: Add mechanism to set the tSendDelay and
 tEchoDelay values
In-Reply-To: <20180626232605.13420-4-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-4-benh@kernel.crashing.org>
Message-ID: <CACPK8XdRk+qgomCV3wZfje_SzLEV12jnqfD_idXOwH=qoZOXZg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Those values control the amount of "dummy" clocks between commands and
> between a command and its response.
>
> This adds a way to configure them from sysfs (to be later extended to
> defaults in the device-tree). The default remains 16 (the HW default).

We should add these to  Documentation/ABI/testing/sysfs-bus-fsi.

> This is only supported if the backend supports the new link_config()
> callback to configure the generation of those delays.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> ---
>  drivers/fsi/fsi-core.c   | 109 ++++++++++++++++++++++++++++++++-------
>  drivers/fsi/fsi-master.h |   2 +
>  2 files changed, 93 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 2f6f9b8c75e4..1ae5be31b4bf 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -81,6 +81,8 @@ struct fsi_slave {
>         int                     id;
>         int                     link;
>         uint32_t                size;   /* size of slave address space */
> +       u8                      t_send_delay;
> +       u8                      t_echo_delay;
>  };
>
>  #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
> @@ -239,15 +241,15 @@ static inline uint32_t fsi_smode_sid(int x)
>         return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
>  }
>
> -static uint32_t fsi_slave_smode(int id)
> +static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)

Can I buy you a vowel? :)

>  {
>         return FSI_SMODE_WSC | FSI_SMODE_ECRC
>                 | fsi_smode_sid(id)
> -               | fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
> +               | fsi_smode_echodly(t_echodly - 1) | fsi_smode_senddly(t_senddly - 1)
>                 | fsi_smode_lbcrr(0x8);
>  }
>
